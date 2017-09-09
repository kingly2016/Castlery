//
//  HomeViewController.m
//  CastleryApp
//
//  Created by Apple on 17/8/26.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductListTableViewCell.h"
#import "ProductListTableViewCell1.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawingLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawingLayout {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView addHeaderWithTarget:self action:@selector(headerRefreshData)];
    [tableView addFooterWithTarget:self action:@selector(footerRefreshData)];
    [self.view addSubview:tableView];
    [tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;

    [self headerRefreshData];
}

- (void)headerRefreshData {
    [[HomeRequest sharedInstance] getProductList:1 withBlock:^(id response) {
        [self.tableView headerEndRefreshing];

        self.dataArray = [NSMutableArray arrayWithArray:response];
        [self.tableView reloadData];
    }];
}

- (void)footerRefreshData {
    NSInteger page = self.dataArray.count / kPageCount + 1;
    [[HomeRequest sharedInstance] getProductList:page withBlock:^(id response) {
        [self.tableView footerEndRefreshing];
        
        if ([response isKindOfClass:[NSArray class]]) {
            if ([response count]) {
                [self.dataArray addObjectsFromArray:response];
                [self.tableView reloadData];
            } else {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDAnimationFade;
                hud.dimBackground = YES;
                hud.removeFromSuperViewOnHide = YES;
                hud.detailsLabelText = @"没有更多了";

                [hud hide:YES afterDelay:1.f];
            }
        }
    }];
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

    //第二行时，只显示四张图片
    if (indexPath.row == 1) {
        static NSString *identifier1 = @"ProductListTableViewCell1";
        ProductListTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell1 == nil) {
            cell1 = [[ProductListTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        //图片
        NSArray *images = [dict objectForKey:@"images"];
        NSString *imageUrl = kHOST;
        imageUrl = [kHOST stringByAppendingPathComponent:images.firstObject];
        [cell1.productImageView1 sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];
        imageUrl = [kHOST stringByAppendingPathComponent:images[1]];
        [cell1.productImageView2 sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];
        imageUrl = [kHOST stringByAppendingPathComponent:images[2]];
        [cell1.productImageView3 sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];
        imageUrl = [kHOST stringByAppendingPathComponent:images.lastObject];
        [cell1.productImageView4 sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];

        return cell1;
    }

    static NSString *identifier = @"ProductListTableViewCell";
    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    //图片
    NSArray *images = [dict objectForKey:@"images"];
    NSString *imageUrl = kHOST;
    imageUrl = [kHOST stringByAppendingPathComponent:images.firstObject];
    [cell.productImageView sd_setImageWithURL:[[NSURL alloc] initWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage];

    //标题
    cell.titleLabel.text = [dict objectForKey:@"title"];
    //价格
    cell.priceLabel.text = [dict objectForKey:@"price"];
    //描述
    cell.descLabel.text = [dict objectForKey:@"description"];
    //运输方式
    cell.deliveryLabel.text = @"免费配送";

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 160.f;
    }
    return 230.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    NSInteger productId = [[dict objectForKey:@"id"] integerValue];
    [[HomeFactory sharedInstance] enterProductDetailVC:self.navigationController productId:productId];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
