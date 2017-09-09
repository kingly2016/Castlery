//
//  ShoppingCartTableViewCell.h
//  CastleryApp
//
//  Created by Apple on 17/8/28.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *totalLabel;
@property (nonatomic, weak) UIImageView *productImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *quantityLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *dateLabel;

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, copy) void(^refreshData)();

@end
