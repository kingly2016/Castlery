//
//  ShoppingCartTableViewCell.m
//  CastleryApp
//
//  Created by Apple on 17/8/28.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "CustomButton.h"

@implementation ShoppingCartTableViewCell


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
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.borderWidth = 1.0f;
    contentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:contentView];
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15.f);
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(-10.f);
        make.bottom.mas_equalTo(0.f);
    }];

    //顶部绿色
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor darkGrayColor];
    [contentView addSubview:topView];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(0.f);
        make.right.mas_equalTo(0.f);
        make.height.mas_equalTo(35.f);
    }];

    //总价
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.textColor = [UIColor whiteColor];
    [topView addSubview:totalLabel];
    [totalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.right.mas_equalTo(contentView).mas_offset(-10.f);
        make.height.mas_equalTo(contentView);
    }];
    self.totalLabel = totalLabel;

    //图片
    UIImageView *productImageView = [[UIImageView alloc] init];
    [contentView addSubview:productImageView];
    [productImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_offset(10.f);
        make.left.mas_equalTo(10.f);
        make.width.mas_equalTo(contentView).multipliedBy(0.5f).mas_offset(-20.f);
        make.height.mas_equalTo(100.f);
    }];
    self.productImageView = productImageView;

    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12.f weight:5];
    [contentView addSubview:titleLabel];
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_offset(10.f);
        make.left.mas_equalTo(contentView.mas_centerX).mas_offset(20.f);
        make.right.mas_equalTo(0.f);
        make.height.mas_equalTo(20.f);
    }];
    self.titleLabel = titleLabel;

    //数量
    UILabel *quantityLabel = [[UILabel alloc] init];
    quantityLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:quantityLabel];
    [quantityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15.f);
        make.left.mas_equalTo(titleLabel);
        make.height.mas_equalTo(20.f);
    }];
    self.quantityLabel = quantityLabel;

    //单价
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:priceLabel];
    [priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(quantityLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(quantityLabel);
        make.height.mas_equalTo(20.f);
    }];
    self.priceLabel = priceLabel;

    //预计发货
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:dateLabel];
    [dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(priceLabel);
        make.height.mas_equalTo(20.f);
    }];
    self.dateLabel = dateLabel;

    //删除
    CustomButton *deleteButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"biz_order_cartlist_del"] forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageNamed:@"biz_order_cartlist_del"] forState:UIControlStateHighlighted];
    [deleteButton setTitle:@" 删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    deleteButton.orientation = 0;
    deleteButton.layer.borderWidth = 1.0f;
    deleteButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [deleteButton addTarget:self action:@selector(onClick_Delete:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:deleteButton];
    [deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(productImageView.mas_bottom).mas_offset(20.f);
        make.left.mas_equalTo(0.f);
        make.width.mas_equalTo(contentView).multipliedBy(0.5f);
        make.height.mas_equalTo(35.f);
        make.bottom.mas_equalTo(0.f);
    }];

    //选中
    CustomButton *selectedButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [selectedButton setImage:[UIImage imageNamed:@"biz_pay_btn_sel_normal"] forState:UIControlStateNormal];
    [selectedButton setImage:[UIImage imageNamed:@"biz_pay_btn_sel_selected"] forState:UIControlStateSelected];
    [selectedButton setTitle:@" 选中" forState:UIControlStateNormal];
    [selectedButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    selectedButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    selectedButton.orientation = 0;
    selectedButton.layer.borderWidth = 1.0f;
    selectedButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    selectedButton.selected = YES;
    [selectedButton addTarget:self action:@selector(onClick_Selected:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:selectedButton];
    [selectedButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(deleteButton);
        make.left.mas_equalTo(deleteButton.mas_right).mas_offset(-1.f);
        make.width.mas_equalTo(contentView).multipliedBy(0.5f).mas_offset(1.f);
        make.height.mas_equalTo(35.f);
        make.bottom.mas_equalTo(0.f);
    }];
}

- (void)onClick_Delete:(UIButton *)sender {
    [[ShoppingCartRequest sharedInstance] removeShoppingCart:self.productId];
    if (self.refreshData) {
        self.refreshData();
    }
}

- (void)onClick_Selected:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

@end
