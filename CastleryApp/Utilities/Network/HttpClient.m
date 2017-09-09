//
//  HttpClient.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "HttpClient.h"

static HttpClient *_sharedInstance = nil;
static dispatch_once_t onceToken;

@interface NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String;

@end

@implementation NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String {
    return (id)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(0, (CFStringRef)self, 0,
                                                                         (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8));
}

@end


@interface HttpClient ()

@property (nonatomic, strong) NSString *currentHost;
@property (nonatomic, assign) NSTimeInterval changedCurrentHostTimeInterval;
@property (nonatomic, assign) NSTimeInterval changeCurrentHostIMTimeInterval;

/**
 *  缓存cookies，不需要每次都从黑盒去获取。
 */
@property (nonatomic, strong) NSArray *cookies;
@property (nonatomic, strong) NSString *userAgent;
/**
 *  网络制式
 */
@property (nonatomic, strong) NSString *reachabilityStatus;

@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

/**
 *  获取完整的URL路径
 *
 *  @param api <#api description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)componentURLWithString:(NSString *)api;

@end

@implementation HttpClient


/**
 *  获取实例，这里不采用单实例模式，因为使用单实例模式是从一个公共的堆栈排序发送http请求的；这里使用多实例，每个http请求独立发送。
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance {

    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:[kHOST stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _sharedInstance = [[HttpClient alloc] initWithBaseURL:url];
        _sharedInstance.currentHost = kHOST;
        _sharedInstance.changedCurrentHostTimeInterval = 0;
        _sharedInstance.changeCurrentHostIMTimeInterval = 0;
        _sharedInstance.reachabilityStatus = @"unkown";//@"未知网络";
        [_sharedInstance ExistenceNetwork];
        _sharedInstance.securityPolicy = nil;
    });

    return _sharedInstance;
}

- (void)get:(NSString *)api withParameters:(NSDictionary *)parameters withCompletionBlock:(completedBlock)block {
    [[HttpClient sharedInstance] GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(error);
        NSLog(@"%@", error.localizedDescription);
    }];

}

/**
 *  <#Description#>
 *
 *  @param api        <#api description#>
 *  @param parameters <#parameters description#>
 *  @param block      <#block description#>
 */
- (AFHTTPRequestOperation *)post:(NSString *)api
                  withParameters:(NSDictionary *)parameters
             withCompletionBlock:(completedBlock)block {

    //完善url
    NSString *urlString = [self componentURLWithString:api];

    //创建网络请求
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:urlString parameters:parameters error:nil];
    //发起网络请求
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析http响应
        [self HTTPResponseOperationWithResponse:api responseObject:responseObject withCompletionBlock:block];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == kCFURLErrorCannotFindHost) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
            [userInfo setObject:@"网络不稳定，请稍后再试！" forKey:NSLocalizedDescriptionKey];
            error  = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
        }
        if (block) {
            block(error);
        }
        NSLog(@"网络请求错误：api=%@，%@", api, error.localizedDescription);
    }];

    [self.operationQueue addOperation:operation];
    return operation;
}

/**
 *  <#Description#>
 *
 *  @param api        <#api description#>
 *  @param parameters <#parameters description#>
 *  @param block      <#block description#>
 */
- (AFHTTPRequestOperation *)post:(NSString *)api
                  withParameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void(^)(id<AFMultipartFormData> formData))bodyBlock
                        progress:(void (^)(float percent))progressBlock
             withCompletionBlock:(completedBlock)block {

    //完善url
    NSString *urlString = [self componentURLWithString:api];
    //创建网络请求，加载附件
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        if (bodyBlock) {
            bodyBlock(formData);
        }

    } error:nil];

    //发起网络请求
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //解析http响应
        [self HTTPResponseOperationWithResponse:api responseObject:responseObject withCompletionBlock:block];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //2016-04-18
        if (error.code == kCFURLErrorCannotFindHost) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
            [userInfo setObject:@"网络不稳定，请稍后再试！" forKey:NSLocalizedDescriptionKey];
            error  = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
        }

        if (block) {
            block(error);
        }
        NSLog(@"网络请求错误：api=%@，%@", api, error.localizedDescription);
    }];

    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progressBlock) {
            progressBlock((float)totalBytesWritten / (float)totalBytesExpectedToWrite);
        }
    }];

    [self.operationQueue addOperation:operation];
    return operation;
}

/**
 *  下载文件放到指定的沙盒目录
 *
 *  @param api           <#api description#>
 *  @param parameters    <#parameters description#>
 *  @param savePath      <#savePath description#>
 *  @param progressBlock <#progressBlock description#>
 *  @param block         <#block description#>
 *
 *  @return <#return value description#>
 */
- (AFHTTPRequestOperation *)download:(NSString *)api
                      withParameters:(NSDictionary *)parameters
                            savePath:(NSString *)savePath
                            progress:(void (^)(float percent))progressBlock
                 withCompletionBlock:(completedBlock)block {

    NSString *urlString = api;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];//POST
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (block) {
            block(responseObject);
        }

        NSLog(@"下载成功");

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
        NSLog(@"网络请求错误：api=%@，%@", api, error.localizedDescription);
    }];

    operation.inputStream = [NSInputStream inputStreamWithURL:[NSURL URLWithString:urlString]];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savePath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        if (progressBlock) {
            progressBlock((float)totalBytesRead / (float)totalBytesExpectedToRead);
        }
    }];

    [self.operationQueue addOperation:operation];
    return operation;
}

/**
 *  配置request
 *
 *  @param theRequest <#theRequest description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)theRequest
                                                    success:(void (^)(AFHTTPRequestOperation *, id))success
                                                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {

    NSMutableURLRequest *request = (NSMutableURLRequest *)theRequest;
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", @"application/octet-stream", nil];

    return operation;
}

/**
 *  解析http响应
 *
 *  @param api            <#api description#>
 *  @param responseObject <#responseObject description#>
 *  @param block          <#block description#>
 */
- (void)HTTPResponseOperationWithResponse:(NSString *)api responseObject:(id)responseObject withCompletionBlock:(void(^)(id response))block {

    //转化为NSMutableDictionary
    NSMutableDictionary *responseDictionary = [NSMutableDictionary dictionaryWithDictionary:responseObject];

    //将密文转换为明文JSON，然后反序列化NSDictionary/NSArray等类型
    NSString *json = [responseDictionary objectForKey:@"data"];
    if (json) {
        //        json = [EncryptHelper base64StringWithDESDecrypt:json withKey:kDES_SecretKey];
        //转换JSON
        NSDictionary *dataValue = [JSONHelper jsonToDictionary:json];
        //移除data节点
        [responseDictionary removeObjectForKey:@"data"];
        //增加节点
        for (NSString *key in dataValue.allKeys) {
            id value = [dataValue objectForKey:key];
            [responseDictionary setObject:value forKey:key];
        }
    }

    /*
     注释：
     错误码	描述
     200	成功
     201	成功 且提示msg的内容
     100	失败 且提示msg的内容
     301	ssid不合法   且提示msg的内容
     302	ssid登录失效  提示msg的内容后，跳用户登录页面
     */
    //返回错误时
    NSError *error;
    NSInteger errCode = [[responseDictionary objectForKey:@"code"] integerValue];
    if (errCode != 200 && errCode != 201) {
        NSString *errMsg = [responseObject objectForKey:@"msg"];
        NSMutableDictionary *errorUserInfo = [NSMutableDictionary dictionaryWithObject:errMsg forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:api code:errCode userInfo:errorUserInfo];
        if (block) {
            block(error);
        }

        return;
    }

    if (block) {
        block(responseDictionary);
    }
}

/**
 *  获取完整的URL路径
 *
 *  @param api <#api description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)componentURLWithString:(NSString *)api {

    NSString *format = [self.currentHost hasSuffix:@"/"] ? @"%@%@" : @"%@/%@";
    NSString *urlString = [NSString stringWithFormat:format, self.currentHost, api];
    return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  存在的网络类型
 */
- (void)ExistenceNetwork {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                self.reachabilityStatus = @"NotNetwork";
                break;
            case AFNetworkReachabilityStatusUnknown:
                self.reachabilityStatus = @"Unknown";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.reachabilityStatus = @"2G/3G/4G";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.reachabilityStatus = @"WiFi";
                break;
            default:
                self.reachabilityStatus = @"Unknown";
                break;
        }
    }];
}

- (void)setReachabilityStatus:(NSString *)reachabilityStatus {
    
    if (reachabilityStatus && ![_reachabilityStatus isEqualToString:reachabilityStatus]) {
        _reachabilityStatus = reachabilityStatus;
    }
}

@end
