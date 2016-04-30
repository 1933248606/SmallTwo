//
//  LoopScrollview.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "LoopScrollview.h"

static NSInteger const imageViewCount = 3;

@interface LoopScrollview () <UIScrollViewDelegate>
@property(weak,nonatomic)UIScrollView *_scr;
@property(weak,nonatomic)NSTimer *timer;


@end


@implementation LoopScrollview

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self._scr = scrollView;
        
        // 图片控件
        for (int i = 0; i<imageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [scrollView addSubview:imageView];
        }
        
        // 页码视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self._scr.frame = self.bounds;
    if (self.scrollDirectionPortrait) {
        self._scr.contentSize = CGSizeMake(0, imageViewCount * self.bounds.size.height);
    } else {
        self._scr.contentSize = CGSizeMake(imageViewCount * self.bounds.size.width, 0);
    }
    
    for (int i = 0; i<imageViewCount; i++) {
        UIImageView *imageView = self._scr.subviews[i];
        if (self.scrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i * self._scr.frame.size.height, self._scr.frame.size.width, self._scr.frame.size.height);
        } else {
            imageView.frame = CGRectMake(i * self._scr.frame.size.width, 0, self._scr.frame.size.width, self._scr.frame.size.height);
        }
    }
    
    [self updateContent];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    // 设置页码
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    
    // 设置内容
    [self updateContent];
    
    // 开始定时器
    [self startTimer];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 找出最中间的那个图片控件
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i<self._scr.subviews.count; i++) {
        UIImageView *imageView = self._scr.subviews[i];
        CGFloat distance = 0;
        if (self.scrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateContent];
}

#pragma mark - 更新内容
- (void)updateContent
{
    // 设置图片
    for (int i = 0; i<self._scr.subviews.count; i++) { // 3
        UIImageView *imageView = self._scr.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        } else if (index >= self.pageControl.numberOfPages) {
            index = 0;
        }
        
        imageView.tag = index;
        imageView.image = self.images[index];
    }
    
    // 设置偏移量在中间
    if (self.scrollDirectionPortrait) {
        self._scr.contentOffset = CGPointMake(0, self._scr.frame.size.height);
    } else {
        self._scr.contentOffset = CGPointMake(self._scr.frame.size.width, 0);
    }
}

#pragma mark - 定时器处理
- (void)startTimer {
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)next {
    if (self.scrollDirectionPortrait) {
        [self._scr setContentOffset:CGPointMake(0, 2 * self._scr.frame.size.height) animated:YES];
    } else {
        [self._scr setContentOffset:CGPointMake(2 * self._scr.frame.size.width, 0) animated:YES];
    }
}



@end
