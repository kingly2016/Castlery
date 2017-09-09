//
//  HomeRequest.h
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRequest : NSObject

/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

- (void)getProductList:(NSInteger)page withBlock:(void(^)(id response))block;

- (void)getProductDetail:(NSInteger)productId withBlock:(void(^)(id response))block;

@end
