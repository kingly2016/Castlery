//
//  HomeRequest.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "HomeRequest.h"
#import "HttpClient.h"

@implementation HomeRequest


/**
 *  获取实例，这里不采用单实例模式，因为使用单实例模式是从一个公共的堆栈排序发送http请求的；这里使用多实例，每个http请求独立发送。
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance {

    static HomeRequest *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HomeRequest alloc] init];
    });

    return _sharedInstance;
}

- (void)getProductList:(NSInteger)page withBlock:(void(^)(id response))block {
    NSString *url = kHttp_ProductList;
    url = [NSString stringWithFormat:url, page, kPageCount];
    [[HttpClient sharedInstance] get:url withParameters:nil withCompletionBlock:^(id response) {
        block(response);
    }];
}


- (void)getProductDetail:(NSInteger)productId withBlock:(void(^)(id response))block {
    NSString *url = kHttp_ProductDetail;
    url = [NSString stringWithFormat:url, productId];
    [[HttpClient sharedInstance] get:url withParameters:nil withCompletionBlock:^(id response) {
        block(response);
    }];
}

@end
