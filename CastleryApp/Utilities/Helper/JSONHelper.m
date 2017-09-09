//
//  JSONHelper.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

/**
 *  把json转为dictionary
 *
 *  @param json <#json description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)jsonToDictionary:(NSString *)json {

    if (!json || [json isEqualToString:@""]) {
        return [NSDictionary dictionary];
    }
    NSError *error;
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *retVal = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    return retVal;
}

/**
 *  把dictionary转化为json
 *
 *  @param dictionary <#dictionary description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)dictionaryToJSON:(NSDictionary *)dictionary {

    NSString *retVal = @"";
    NSError *error;
    BOOL b = [NSJSONSerialization isValidJSONObject:dictionary];
    if (!b) {
        return retVal;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (!data) {
        NSLog(@"%@", error);
    }
    retVal = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return retVal;
}


@end
