//
//  BaseViewController.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (IS_IOS7Later) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.modalPresentationCapturesStatusBarAppearance = NO;

        //保证导航栏背景为设置的颜色
        self.navigationController.navigationBar.translucent = NO;
        //底部的tabBar原始颜色
        self.tabBarController.tabBar.translucent = NO;
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  设置导航背景，设置标题，是否显示返回按钮
 *
 *  @param title                    <#title description#>
 *  @param displayLeftBarButtonItem <#displayLeftBarButtonItem description#>
 */
- (void)setNavgationBar:(NSString *)title displayLeftBarButtonItem:(BOOL)displayLeftBarButtonItem {
    [self clearBarButtonItem];
    self.title = title;
    if (displayLeftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [self setLeftBarButtonItem];
    }
}

/**
 *  设置导航背景，设置标题，是否显示返回按钮，设置右边按钮
 *
 *  @param title                    <#title description#>
 *  @param displayLeftBarButtonItem <#displayLeftBarButtonItem description#>
 *  @param rightBarButtonItem       rightBarButtonItem
 */
- (void)setNavgationBar:(NSString *)title displayLeftBarButtonItem:(BOOL)displayLeftBarButtonItem
     rightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {

    [self clearBarButtonItem];
    self.title = title;

    if (displayLeftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [self setLeftBarButtonItem];
    }
    if (rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

/**
 *  设置导航背景，设置标题，设置返回按钮，设置右边按钮
 *
 *  @param title              <#title description#>
 *  @param leftBarButtonItem  <#leftBarButtonItem description#>
 *  @param rightBarButtonItem <#rightBarButtonItem description#>
 */
- (void)setNavgationBar:(NSString *)title leftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
     rightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {

    [self clearBarButtonItem];
    self.title = title;
    if (leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    if (rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
}

- (void)clearBarButtonItem {
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

/**
 *  设置导航栏左键为返回键
 *
 *  @return <#return value description#>
 */
- (UIBarButtonItem *)setLeftBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(previousClick:)];
}

/**
 *  返回上一页，针对点击导航栏返回按钮事件
 */
- (void)previousClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  返回上一页，代码执行返回事件，这里主要区别ios8.0版本以前的。
 *  如果ios版本号大于8.0，则使用动画退回方式，否则不要使用动画方式，ios8.0以前的版本使用代码调用退回上一页，接着进入某个页面经常会导致导航栏标题混乱，原因是在ios8.0以前的版本，退回的动画还没有执行，就进入了下一个页面。
 */
- (void)autoPreviousClick {
    if (CURRENT_SYS_VERSION >= 8.0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

/**
 *  点击空白处隐藏键盘
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
