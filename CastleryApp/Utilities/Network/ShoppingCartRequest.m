//
//  ShoppingCartRequest.m
//  CastleryApp
//
//  Created by Apple on 17/8/29.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ShoppingCartRequest.h"

@implementation ShoppingCartRequest

/**
 *  获取实例，这里不采用单实例模式，因为使用单实例模式是从一个公共的堆栈排序发送http请求的；这里使用多实例，每个http请求独立发送。
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance {

    static ShoppingCartRequest *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ShoppingCartRequest alloc] init];
    });

    return _sharedInstance;
}

- (NSMutableArray *)getShoppingCart {
    NSMutableArray *array = [[CacheManager sharedInstance] objectForUserKey:@"ShoppingCart"];
    return [NSMutableArray arrayWithArray:array];
}

- (void)addShoppingCart:(NSMutableDictionary *)productDict {
    NSMutableArray *dataArray = [self getShoppingCart];
    if (dataArray == nil) {
        dataArray = [NSMutableArray array];
    }

    NSMutableDictionary *dict;
    for (NSMutableDictionary *d in dataArray) {
        NSInteger productId = [[d objectForKey:@"productId"] integerValue];
        NSInteger productIdNew = [[productDict objectForKey:@"productId"] integerValue];
        if (productId == productIdNew) {
            dict = d;
        }
    }
    if (dict) {
        NSInteger index = [dataArray indexOfObject:dict];
        NSInteger quantity = [dict[@"quantity"] integerValue] + 1;
        NSMutableDictionary *dictNew = [NSMutableDictionary dictionaryWithDictionary:dict];
        [dictNew setObject:@(quantity) forKey:@"quantity"];
        [dataArray insertObject:dictNew atIndex:index];
        [dataArray removeObject:dict];
    } else {
        [dataArray addObject:productDict];
    }
    [[CacheManager sharedInstance] setObject:dataArray forUserKey:@"ShoppingCart"];
}

- (void)removeShoppingCart:(NSInteger)productId {
    NSMutableArray *dataArray = [self getShoppingCart];
    if (dataArray == nil) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.productId=%d", productId];
    NSArray *array = [dataArray filteredArrayUsingPredicate:predicate];
    if (array.count) {
        [dataArray removeObject:array.firstObject];
        [[CacheManager sharedInstance] setObject:dataArray forUserKey:@"ShoppingCart"];
    }
}


@end
