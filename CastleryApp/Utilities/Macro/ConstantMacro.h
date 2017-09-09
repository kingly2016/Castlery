//
//  ConstantMacro.h
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#ifndef ConstantMacro_h
#define ConstantMacro_h

//每次从服务端获取7条数据
#define kPageCount                          7

//默认图片
#define kPlaceholderPhotoImage [UIImage imageNamed:@"defaultImage"]

//系统版本
#define IS_IOS7Later ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) ? YES :NO

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//屏幕大小
#define MDK_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define MDK_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#endif /* ConstantMacro_h */
