//
//  HttpClient.h
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFNetworking.h"
//Macro
#import "NetworkMacro.h"
//Helper
#import "JSONHelper.h"

/**
 *  定义block类型
 *
 *  @param response <#response description#>
 *
 */
typedef void(^completedBlock)(id response);

@interface HttpClient : AFHTTPRequestOperationManager

/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

- (void)get:(NSString *)api withParameters:(NSDictionary *)parameters withCompletionBlock:(completedBlock)block;

/**
 *  <#Description#>
 *
 *  @param api        <#api description#>
 *  @param parameters <#parameters description#>
 *  @param block      <#block description#>
 */
- (AFHTTPRequestOperation *)post:(NSString *)api
                  withParameters:(NSDictionary *)parameters
             withCompletionBlock:(completedBlock)block;

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
             withCompletionBlock:(completedBlock)block;

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
                 withCompletionBlock:(completedBlock)block;

@end
