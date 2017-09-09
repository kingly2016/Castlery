//
//  CacheManager.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager


/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance {

    static CacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CacheManager alloc] init];
    });

    return _sharedInstance;
}

/**
 *  根据关键字保存对象
 *
 *  @param anObject <#value description#>
 *  @param aKey   <#key description#>
 */
- (void)setObject:(id)anObject forUserKey:(NSString *)aKey {
    if (anObject == nil) {
        return;
    }

    @try {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:anObject forKey:aKey];
        [userDefaults synchronize];
    }
    @catch (NSException *exception) {

    }
    @finally {
        
    }
}

/**
 *  根据关键字读取对象
 *
 *  @param aKey <#key description#>
 */
- (id)objectForUserKey:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:aKey];
}

/**
 *  存储归档数据
 *
 *  @param anObject <#anObject description#>
 *  @param aKey     <#aKey description#>
 */
- (void)setObjectWithArchiver:(id)anObject forUserKey:(NSString *)aKey {
    if (anObject == nil) {
        return;
    }
    @try {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:anObject];
        [self setObject:data forUserKey:aKey];
    }
    @catch (NSException *exception) {

    }
    @finally {

    }
}

/**
 *  获取归档数据
 *
 *  @param aKey <#aKey description#>
 *
 *  @return <#return value description#>
 */
- (id)objectWithArchiverForUserKey:(NSString *)aKey {
    NSData *data = [self objectForUserKey:aKey];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

/**
 *  移除项
 *
 *  @param aKey <#aKey description#>
 */
- (void)removeObjectForKey:(NSString *)aKey {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:aKey];
    [userDefaults synchronize];
}

@end
