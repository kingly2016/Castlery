//
//  StyleCollectionView.m
//  CastleryApp
//
//  Created by Apple on 17/8/28.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import "StyleCollectionView.h"

static NSString *identifier = @"cell";

@interface StyleCollectionView ()

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation StyleCollectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self drawingLayout];
    }

    return self;
}

/**
 *  布局界面
 */
- (void)drawingLayout {

    self.backgroundColor = [UIColor clearColor];

    //样式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(50.0, 50.0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //UICollectionView
    CGRect frame = CGRectMake(0.0, 0.0, MDK_SCREEN_WIDTH, 50.f);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    //隐藏滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    collectionView.userInteractionEnabled = YES;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

/**
 *  行数
 *
 *  @param collectionView <#collectionView description#>
 *  @param section        <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.styleImages.count;
}

/**
 *  section
 *
 *  @param collectionView <#collectionView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 *  画单元格
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.styleImages.count <= indexPath.row) {
        return nil;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *styleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    styleImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    styleImageView.layer.borderWidth = 0.5f;
    [cell.contentView addSubview:styleImageView];
    //头像
    NSString *imageUrl = [self.styleImages objectAtIndex:indexPath.row];
    [styleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:kPlaceholderPhotoImage options:SDWebImageRetryFailed | SDWebImageCacheMemoryOnly];

    return cell;
}

/**
 *  行间距
 *
 *  @param collectionView       <#collectionView description#>
 *  @param collectionViewLayout <#collectionViewLayout description#>
 *  @param section              <#section description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 3.00;
}

/**
 *  选中单元格
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中沙发颜色");
}

- (void)setStyleImages:(NSMutableArray *)styleImages {
    _styleImages = styleImages;
    [self.collectionView reloadData];
}

@end
