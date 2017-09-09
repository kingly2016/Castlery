//
//  BaseViewController.h
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
 *  设置导航背景，设置标题，是否显示返回按钮
 *
 *  @param title                    <#title description#>
 *  @param displayLeftBarButtonItem <#displayLeftBarButtonItem description#>
 */
- (void)setNavgationBar:(NSString *)title displayLeftBarButtonItem:(BOOL)displayLeftBarButtonItem;

/**
 *  设置导航背景，设置标题，是否显示返回按钮，设置右边按钮
 *
 *  @param title                    <#title description#>
 *  @param displayLeftBarButtonItem <#displayLeftBarButtonItem description#>
 *  @param rightBarButtonItem       rightBarButtonItem description
 */
- (void)setNavgationBar:(NSString *)title displayLeftBarButtonItem:(BOOL)displayLeftBarButtonItem
     rightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;

/**
 *  设置导航背景，设置标题，设置返回按钮，设置右边按钮
 *
 *  @param title              <#title description#>
 *  @param leftBarButtonItem  <#leftBarButtonItem description#>
 *  @param rightBarButtonItem <#rightBarButtonItem description#>
 */
- (void)setNavgationBar:(NSString *)title leftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
     rightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;

@end
