//
//  ShoppingCartViewController.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawingLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self headerRefreshData];
}

//显示购物车空白图片
- (void)showEmptyImage {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.tag = 1000;
    imageView.image = [UIImage imageNamed:@"no_Pack"];
    [self.view addSubview:imageView];
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(173.f);
        make.height.mas_equalTo(226.5f);
    }];
}

- (void)drawingLayout {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [tableView addHeaderWithTarget:self action:@selector(headerRefreshData)];
    [self.view addSubview:tableView];
    [tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
}

- (void)headerRefreshData {
    self.dataArray = [[ShoppingCartRequest sharedInstance] getShoppingCart];

    [self.tableView headerEndRefreshing];
    [self.tableView reloadData];

    if (self.dataArray.count == 0) {
        [self showEmptyImage];
    } else {
        UIImageView *imageView = [self.view viewWithTag:1000];
        [imageView removeFromSuperview];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

/**
 *  section个数
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MDK_SCREEN_WIDTH, 15.f)];
    bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    return bgView;
}

/**
 *  每个section的行数
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


/**
 *  画cell
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];

    static NSString *identifier = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    //图片
    NSArray *images = [dict objectForKey:@"images"];
    NSString *imageUrl = kHOST;
    imageUrl = [kHOST stringByAppendingPathComponent:images.firstObject];
    [cell.productImageView sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];

    //标题
    cell.titleLabel.text = [dict objectForKey:@"title"];
    //价格
    cell.priceLabel.text = [NSString stringWithFormat:@"单价：%@", [dict objectForKey:@"price"]];
    //数量
    cell.quantityLabel.text = [NSString stringWithFormat:@"数量：%@", [dict objectForKey:@"quantity"]];
    //总价
    NSArray *array = [[dict objectForKey:@"price"] componentsSeparatedByString:@" "];
    float price = [array.firstObject floatValue];
    float total = price * [[dict objectForKey:@"quantity"] integerValue];
    cell.totalLabel.text = [NSString stringWithFormat:@"￥%0.2f", total];
    //发货日期
    cell.dateLabel.text = [NSString stringWithFormat:@"预计发货：%@", [dict objectForKey:@"date"]];

    cell.productId = [[dict objectForKey:@"productId"] integerValue];
    cell.refreshData = ^() {
        [self headerRefreshData];
    };
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSInteger productId = [[dict objectForKey:@"id"] integerValue];
    [[HomeFactory sharedInstance] enterProductDetailVC:self.navigationController productId:productId];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
