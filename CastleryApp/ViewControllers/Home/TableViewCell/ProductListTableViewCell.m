//
//  ProductListTableViewCell.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ProductListTableViewCell.h"

@implementation ProductListTableViewCell


/**
 *  初始化
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawingLayout];
    }

    return self;
}

/**
*  布局界面
*/
- (void)drawingLayout {
    UIView *contentView = self.contentView;

    //图片
    UIImageView *productImageView = [[UIImageView alloc] init];
    productImageView.contentMode = UIViewContentModeScaleToFill;
    [contentView addSubview:productImageView];
    [productImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.mas_equalTo(contentView);
        make.height.mas_equalTo(150.0f);
    }];
    self.productImageView = productImageView;

    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:11.0 weight:5];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:priceLabel];
    [priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(productImageView.mas_bottom).mas_offset(10.f);
        make.right.mas_equalTo(contentView).mas_offset(-20.f);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(20.f);
    }];
    self.priceLabel = priceLabel;

    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12.f weight:5];
    [contentView addSubview:titleLabel];
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(productImageView.mas_bottom).mas_offset(10.0f);
        make.left.mas_equalTo(15.0f);
        make.right.mas_equalTo(priceLabel.mas_left).mas_offset(-20.f);
    }];
    self.titleLabel = titleLabel;

    //描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = [UIColor grayColor];
    descLabel.numberOfLines = 1;
    descLabel.font = [UIFont systemFontOfSize:11.f];
    [contentView addSubview:descLabel];
    [descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(contentView).mas_offset(-10.f);
    }];
    self.descLabel = descLabel;

    //配送方式
    UILabel *deliveryLabel = [[UILabel alloc] init];
    deliveryLabel.textColor = [UIColor redColor];
    deliveryLabel.font = [UIFont systemFontOfSize:11.0f];
    [contentView addSubview:deliveryLabel];
    [deliveryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(descLabel);
        make.height.mas_equalTo(20.f);
    }];
    self.deliveryLabel = deliveryLabel;
}

@end
