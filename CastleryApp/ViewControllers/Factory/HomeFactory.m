//
//  HomeFactory.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "HomeFactory.h"
#import "ProductDetailViewController.h"

@implementation HomeFactory

+ (instancetype)sharedInstance {

    static HomeFactory *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HomeFactory alloc] init];
    });

    return _sharedInstance;
}

- (void)enterProductDetailVC:(UINavigationController *)navigationCtr productId:(NSInteger)productId {
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.productId = productId;
    vc.hidesBottomBarWhenPushed = YES;
    [navigationCtr pushViewController:vc animated:YES];
}

@end
