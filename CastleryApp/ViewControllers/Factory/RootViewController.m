//
//  RootViewController.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawingLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)drawingLayout {
    self.delegate = self;

    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    ShoppingCartViewController *shoppingCartViewController = [[ShoppingCartViewController alloc] init];
    MeViewController *meViewController = [[MeViewController alloc] init];

    NSArray *viewControllers = [[NSArray alloc] initWithObjects:homeViewController, shoppingCartViewController, meViewController, nil];
    NSArray *viewControllerTitles = [[NSArray alloc] initWithObjects:@"首页", @"购物车", @"我的", nil];
    NSArray *viewControllerImages = [[NSArray alloc] initWithObjects:@"zy", @"gwc", @"w", nil];
    NSArray *viewControllerSelectedImages = [[NSArray alloc] initWithObjects:@"zy1", @"gwc1", @"w1", nil];

    NSMutableArray *navViewControllers = [NSMutableArray array];
    for (int i = 0; i < viewControllers.count; i ++) {
        UIViewController *vc = [viewControllers objectAtIndex:i];
        vc.title = [viewControllerTitles objectAtIndex:i];

        UIImage *image = [UIImage imageNamed:[viewControllerImages objectAtIndex:i]];
        UIImage *selectedImage = [UIImage imageNamed:[viewControllerSelectedImages objectAtIndex:i]];
        vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        vc.tabBarItem.title = @"";
        [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
        UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:vc];

        [navViewControllers addObject:navViewController];
    }

    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    self.viewControllers = navViewControllers;
}

@end
