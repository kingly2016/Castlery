//
//  ProductListTableViewCell1.m
//  CastleryApp
//
//  Created by Apple on 17/8/27.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ProductListTableViewCell1.h"

@implementation ProductListTableViewCell1


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

    //图片1
    UIImageView *productImageView1 = [[UIImageView alloc] init];
    [contentView addSubview:productImageView1];
    [productImageView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView).multipliedBy(0.5);
        make.centerY.mas_equalTo(contentView).multipliedBy(0.5);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(80.0f);
    }];
    self.productImageView1 = productImageView1;

    //图片2
    UIImageView *productImageView2 = [[UIImageView alloc] init];
    [contentView addSubview:productImageView2];
    [productImageView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView).multipliedBy(1.5);
        make.centerY.mas_equalTo(contentView).multipliedBy(0.5);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(80.0f);

    }];
    self.productImageView2 = productImageView2;

    //图片3
    UIImageView *productImageView3 = [[UIImageView alloc] init];
    [contentView addSubview:productImageView3];
    [productImageView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView).multipliedBy(0.5);
        make.centerY.mas_equalTo(contentView).multipliedBy(1.5);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(80.0f);
    }];
    self.productImageView3 = productImageView3;

    //图片4
    UIImageView *productImageView4 = [[UIImageView alloc] init];
    [contentView addSubview:productImageView4];
    [productImageView4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contentView).multipliedBy(1.5);
        make.centerY.mas_equalTo(contentView).multipliedBy(1.5);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(80.0f);
    }];
    self.productImageView4 = productImageView4;
}

@end
