//
//  HomeFactory.h
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeFactory : NSObject

/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

/**
 *  打开产品详情
 *
 */
- (void)enterProductDetailVC:(UINavigationController *)navigationCtr productId:(NSInteger)productId;

@end
