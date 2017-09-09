//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by Kingly on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"

@interface CycleScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) NSMutableArray *contentViews;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL isAutoTimerScroll;

@end

@implementation CycleScrollView

/**
 *  初始化
 *
 *  @param frame             <#frame description#>
 *  @param animationDuration <#animationDuration description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;

        CGRect frame = CGRectMake((self.frame.size.width - 200) / 2, self.frame.size.height - 20, 200, 20);
        self->pageControl = [[UIPageControl alloc] initWithFrame:frame];
        [self addSubview:self->pageControl];

        self.animationDuration = animationDuration;
    }

    return self;
}

/**
 *  创建定时器
 */
- (void)setupTimer {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:self.animationDuration target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
    self.isAutoTimerScroll = YES;
}

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount {
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
//        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        [self setupTimer];
    }
    self->pageControl.numberOfPages = _totalPageCount;
}

#pragma mark -
#pragma mark - 私有函数
- (void)configContentViews {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource {
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }

    if (self.views) {
        [self.contentViews addObject:[self.views objectAtIndex:previousPageIndex]];
        [self.contentViews addObject:[self.views objectAtIndex:_currentPageIndex]];
        [self.contentViews addObject:[self.views objectAtIndex:rearPageIndex]];
    }
}

/**
 *  获取下一张照片的索引
 *
 *  @param currentPageIndex <#currentPageIndex description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex; {
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.animationTimer pauseTimer];
//    [self.animationTimer invalidate];
    self.isAutoTimerScroll = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
//    [self setupTimer];
    self.isAutoTimerScroll = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    DLog(@"%@", @(self.autoScroll));

    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        NSLog(@"next，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex -1];
//        NSLog(@"previous，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    self->pageControl.currentPage = self.currentPageIndex;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件
- (void)animationTimerDidFired:(NSTimer *)timer {
    if (self.isAutoTimerScroll) {
        CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:newOffset animated:YES];
    }
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap {
    if (self.tapActionBlock) {
        self.tapActionBlock(self.currentPageIndex);
    }
}

@end
