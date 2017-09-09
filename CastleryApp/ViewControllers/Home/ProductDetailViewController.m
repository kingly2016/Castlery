//
//  ProductDetailViewController.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "CycleScrollView.h"
#import "StyleCollectionView.h"
#import "UIColor+Utility.h"
#import "CustomButton.h"
#import "ShoppingCartViewController.h"

@interface ProductDetailViewController ()

@property (nonatomic, weak) CycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *dateLabel;
@property (nonatomic, weak) UILabel *deliveryLabel;
@property (nonatomic, weak) UILabel *styleLabel;
@property (nonatomic, weak) StyleCollectionView *styleCollectionView;

@property (nonatomic, strong) NSMutableDictionary *productDictionary;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBar:@"产品详情" displayLeftBarButtonItem:YES rightBarButtonItem:self.rightBarButtonItem];

    [self drawingLayout];
    //self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawingLayout {
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    CGRect frame = CGRectMake(0.0, 0.0, MDK_SCREEN_WIDTH, 250.f);
    CycleScrollView *cycleScrollView = [[CycleScrollView alloc] initWithFrame:frame animationDuration:3.f];
    [contentView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;

    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14.f weight:5];
    [contentView addSubview:titleLabel];
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cycleScrollView.mas_bottom).mas_offset(10.f);
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(20.f);
    }];
    self.titleLabel = titleLabel;

    //描述
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.textColor = [UIColor grayColor];
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:descLabel];
    [descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(titleLabel);
        make.width.mas_equalTo(MDK_SCREEN_WIDTH - 40.f);
    }];
    self.descLabel = descLabel;

    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:11.0 weight:5];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:priceLabel];
    [priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cycleScrollView.mas_bottom).mas_offset(10.f);
        make.right.mas_equalTo(descLabel);
        make.width.mas_equalTo(80.f);
        make.height.mas_equalTo(20.f);
    }];
    self.priceLabel = priceLabel;

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

    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentView addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(deliveryLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(deliveryLabel);
        make.width.mas_equalTo(MDK_SCREEN_WIDTH - 40.f);
        make.height.mas_equalTo(1.f);
    }];

    //分享
    CustomButton *shareButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"biz_show_share_default"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"biz_show_share_pressed"] forState:UIControlStateHighlighted];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    shareButton.orientation = 0;
    [contentView addSubview:shareButton];
    [shareButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(deliveryLabel);
        make.right.mas_equalTo(priceLabel);
        make.width.mas_equalTo(60.f);
        make.height.mas_equalTo(25.f);
    }];

    //收藏
    CustomButton *favButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [favButton setImage:[UIImage imageNamed:@"biz_show_fav_default"] forState:UIControlStateNormal];
    [favButton setImage:[UIImage imageNamed:@"biz_show_fav_selected"] forState:UIControlStateHighlighted];
    [favButton setTitle:@"收藏" forState:UIControlStateNormal];
    [favButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    favButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    favButton.orientation = 0;
    [contentView addSubview:favButton];
    [favButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(shareButton);
        make.right.mas_equalTo(shareButton.mas_left);
        make.width.mas_equalTo(60.f);
        make.height.mas_equalTo(25.f);
    }];

    //上架时间
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.font = [UIFont systemFontOfSize:11.0f];
    [contentView addSubview:dateLabel];
    [dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(deliveryLabel);
        make.height.mas_equalTo(20.f);
    }];
    self.dateLabel = dateLabel;

    //可选颜色
    UILabel *styleLabel = [[UILabel alloc] init];
    styleLabel.text = @"可选颜色：";
    styleLabel.font = [UIFont systemFontOfSize:11.0f];
    [contentView addSubview:styleLabel];
    [styleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dateLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(dateLabel);
        make.width.mas_equalTo(300.f);
        make.height.mas_equalTo(20.f);
    }];
    self.styleLabel = styleLabel;

    //颜色图片
    StyleCollectionView *styleCollectionView = [[StyleCollectionView alloc] init];
    [contentView addSubview:styleCollectionView];
    [styleCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(styleLabel.mas_bottom).mas_offset(5.f);
        make.left.mas_equalTo(10.f);
        make.width.mas_equalTo(MDK_SCREEN_WIDTH - 20.f);
        make.height.mas_equalTo(50.f);
    }];
    self.styleCollectionView = styleCollectionView;

    //底部购买
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    bottomView.layer.borderColor = [UIColor grayColor].CGColor;
    //bottomView.layer.borderWidth = 1.f;
    [self.view addSubview:bottomView];
    [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(-1.f);
        make.right.mas_equalTo(1.f);
        make.bottom.mas_equalTo(1.f);
        make.height.mas_equalTo(45.f);
    }];

    //客服聊天
    UIButton *customerButton = [[UIButton alloc] init];
    UIImage *imageNormal = [UIImage imageNamed:@"chat"];
    UIImage *imageSelected = [UIImage imageNamed:@"chat1"];
    [customerButton setImage:imageNormal forState:UIControlStateNormal];
    [customerButton setImage:imageSelected forState:UIControlStateHighlighted];
    [customerButton addTarget:self action:@selector(onClick_Chat:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:customerButton];
    [customerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(0.f);
        make.bottom.mas_equalTo(0.f);
        make.width.mas_equalTo(bottomView).multipliedBy(0.3);
    }];

    //喜欢
    UIButton *likeButton = [[UIButton alloc] init];
    likeButton.tag = 1;
    likeButton.selected = YES;
    imageNormal = [UIImage imageNamed:@"like"];
    imageSelected = [UIImage imageNamed:@"like1"];
    [likeButton setImage:imageNormal forState:UIControlStateNormal];
    [likeButton setImage:imageSelected forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(onClick_Like:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:likeButton];
    [likeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(customerButton.mas_right);
        make.bottom.mas_equalTo(0.f);
        make.width.mas_equalTo(bottomView).multipliedBy(0.3);
    }];

    //购物车
    UIButton *shoppingCartButton = [[UIButton alloc] init];
    [shoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    shoppingCartButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
    imageNormal = [UIColor createImageWithColor:[UIColor blackColor]];
    imageSelected = [UIColor createImageWithColor:[UIColor groupTableViewBackgroundColor]];
    [shoppingCartButton setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [shoppingCartButton setBackgroundImage:imageSelected forState:UIControlStateSelected];
    [shoppingCartButton addTarget:self action:@selector(onClick_ShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shoppingCartButton];
    [shoppingCartButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(likeButton.mas_right);
        make.bottom.mas_equalTo(0.f);
        make.width.mas_equalTo(bottomView).multipliedBy(0.4);
    }];

    //加载数据
    [self loadData];
}

- (void)loadData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = @"正在加载......";
    [[HomeRequest sharedInstance] getProductDetail:self.productId withBlock:^(id response) {
        [hud hide:YES afterDelay:0.3f];
        self.productDictionary = [NSMutableDictionary dictionaryWithDictionary:response];

        NSArray *images = [response objectForKey:@"images"];
        [self addCycleScrollSubView:images];

        self.titleLabel.text = [response objectForKey:@"title"];
        self.descLabel.text = [response objectForKey:@"description"];
        self.priceLabel.text = [response objectForKey:@"price"];
        self.deliveryLabel.text = @"免费配送";

        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
        NSString *dateString = [response objectForKey:@"available_since"];
        NSDate *date = [dateFormatter dateFromString:dateString];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
        self.dateLabel.text = [NSString stringWithFormat:@"上架时间：%ld年%ld月%ld日", components.year, components.month, components.day];
        NSMutableArray *styleImages = [NSMutableArray array];
        for (NSString *imageName in images) {
            NSString *imageUrl = [kHOST stringByAppendingPathComponent:imageName];
            [styleImages addObject:imageUrl];
        }
        self.styleCollectionView.styleImages = styleImages;
    }];
}

- (void)addCycleScrollSubView:(NSArray *)images {
    self.imageViews = [NSMutableArray array];

    for (NSString *imageName in images) {
        NSString *imageUrl = [kHOST stringByAppendingPathComponent:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, MDK_SCREEN_WIDTH, CGRectGetHeight(self.cycleScrollView.frame))];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage options:SDWebImageRetryFailed | SDWebImageCacheMemoryOnly];

        [self.imageViews addObject:imageView];
    }

    self.cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return [self.imageViews objectAtIndex:pageIndex];
    };
    self.cycleScrollView.totalPagesCount = ^NSInteger(void) {
        return self.imageViews.count;
    };
}

- (void)onClick_Chat:(UIButton *)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = @"正在启动聊天页面......";
    [hud hide:YES afterDelay:2.f];
}

- (void)onClick_Like:(UIButton *)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;

    if (sender.tag == 0) {
        sender.tag = 1;
        sender.selected = YES;
        hud.detailsLabelText = @"正在喜欢......";
    } else {
        sender.tag = 0;
        sender.selected = NO;
        hud.detailsLabelText = @"正在取消喜欢......";
    }

    [hud hide:YES afterDelay:2.f];
}

- (void)onClick_ShoppingCart:(UIButton *)sender {
    if ([self.productDictionary[@"id"] integerValue] > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDAnimationFade;
        hud.dimBackground = YES;
        hud.removeFromSuperViewOnHide = YES;

        self.productDictionary[@"productId"] = self.productDictionary[@"id"];
        self.productDictionary[@"quantity"] = @(1);
        self.productDictionary[@"date"] = @"2017-10-10";

        [[ShoppingCartRequest sharedInstance] addShoppingCart:self.productDictionary];

        hud.detailsLabelText = @"已经加入购物车";
        [hud hide:YES afterDelay:2.f];
    }
}


/**
 *  设置导航栏右键
 *
 *  @return <#return value description#>
 */
- (UIBarButtonItem *)rightBarButtonItem {
    CGRect frame = CGRectMake(0, 0, 45, 45);
    UIButton *rightBarButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButtonItem.frame = frame;
    [rightBarButtonItem setImage:[UIImage imageNamed:@"gwc"] forState:UIControlStateNormal];
    [rightBarButtonItem setImage:[UIImage imageNamed:@"gwc1"] forState:UIControlStateHighlighted];
    [rightBarButtonItem addTarget:self action:@selector(rightBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItem];
}

- (void)rightBarButtonItemClick:(id)sender {
    [[ShoppingCartFactory sharedInstance] enterShoppingCartVC:self.navigationController];
}

@end
