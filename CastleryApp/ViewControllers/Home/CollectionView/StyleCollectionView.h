//
//  StyleCollectionView.h
//  CastleryApp
//
//  Created by Apple on 17/8/28.
//  Copyright © 2017年 com.castlery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StyleCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *styleImages;

@end
