//
//  CacheManager.h
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//
//  主要存储到App本地黑盒的数据
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

/**
 *  获取实例
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance;

/**
 *  根据关键字保存对象
 *
 *  @param anObject <#value description#>
 *  @param aKey   <#key description#>
 */
- (void)setObject:(id)anObject forUserKey:(NSString *)aKey;
/**
 *  根据关键字读取对象
 *
 *  @param aKey <#key description#>
 */
- (id)objectForUserKey:(NSString *)aKey;
/**
 *  存储归档数据
 *
 *  @param anObject <#anObject description#>
 *  @param aKey     <#aKey description#>
 */
- (void)setObjectWithArchiver:(id)anObject forUserKey:(NSString *)aKey;
/**
 *  获取归档数据
 *
 *  @param aKey <#aKey description#>
 *
 *  @return <#return value description#>
 */
- (id)objectWithArchiverForUserKey:(NSString *)aKey;

/**
 *  移除项
 *
 *  @param aKey <#aKey description#>
 */
- (void)removeObjectForKey:(NSString *)aKey;

@end
