//
//  ShoppingCartFactory.h
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartFactory : NSObject


/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

- (void)enterShoppingCartVC:(UINavigationController *)navigationCtr;

@end
