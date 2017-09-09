//
//  ShoppingCartFactory.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ShoppingCartFactory.h"

@implementation ShoppingCartFactory


+ (instancetype)sharedInstance {

    static ShoppingCartFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ShoppingCartFactory alloc] init];
    });

    return _sharedInstance;
}


- (void)enterShoppingCartVC:(UINavigationController *)navigationCtr {
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    vc.title = @"购物车";
    [vc setNavgationBar:vc.title displayLeftBarButtonItem:YES];
    [navigationCtr pushViewController:vc animated:YES];
}

@end
