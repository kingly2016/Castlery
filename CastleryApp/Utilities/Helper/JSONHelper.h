//
//  JSONHelper.h
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//
//  json和NSDcitionary相互转换
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

/**
 *  把json转为dictionary
 *
 *  @param json <#json description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)jsonToDictionary:(NSString *)json;

/**
 *  把dictionary转化为json
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)dictionaryToJSON:(NSDictionary *)dictionary;

@end
