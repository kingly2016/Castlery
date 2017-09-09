//
//  ShoppingCartRequest.h
//  CastleryApp
//
//  Created by Apple on 17/8/29.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartRequest : NSObject
/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

- (NSMutableArray *)getShoppingCart;

- (void)addShoppingCart:(NSMutableDictionary *)productDict;

- (void)removeShoppingCart:(NSInteger)productId;

@end
