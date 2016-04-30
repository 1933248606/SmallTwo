//
//  ViewController.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/15.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ViewController.h"
#import "Tool_h.h"
#import "HomePageViewController.h"
#import "QYAdvClassHttpRequest.h"
@interface ViewController ()
{
    UIScrollView *_scr;//启动页滚动视图
    UIPageControl *_pageControl;//页面控制器
    ViewController *viewcontroller;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scr = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _scr.contentSize = CGSizeMake(WIDTH*3, HEIGHT);
    _scr.delegate = self;
    _scr.showsHorizontalScrollIndicator = NO;
    _scr.showsVerticalScrollIndicator = NO;
    _scr.scrollEnabled = YES;
    _scr.pagingEnabled = YES;
    _scr.bounces = NO;
    
    NSMutableArray *iconArr = [[NSMutableArray alloc]initWithObjects:@"night8.jpg",@"night9.jpg",@"night10.jpg", nil];
    for (int i = 0; i<3; i++)
    {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT)];
        imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:i]];
        [_scr addSubview:imageView];
    }
    _pageControl = [UIPageControl new];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [_pageControl addTarget:self action:@selector(PageMethod:) forControlEvents:(UIControlEventTouchUpInside)];
    UIButton *AccessBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    AccessBtn.frame = CGRectMake(WIDTH*3-WIDTH/3*2, HEIGHT-HEIGHT/12, WIDTH/3, HEIGHT/16);
    [AccessBtn setTitle:@"进入体验" forState:(UIControlStateNormal)];
    AccessBtn.backgroundColor = [UIColor orangeColor];
    [AccessBtn addTarget:self action:@selector(AccessBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:AccessBtn];
    [self.view addSubview:_scr];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/WIDTH;
    _pageControl.currentPage = page;
}
-(void)PageMethod:(UIPageControl*)pagecontrolone
{
    NSInteger pageNumber = pagecontrolone.currentPage;
    
    [_scr setContentOffset:CGPointMake(pageNumber *320, 0) animated:YES];
}
-(void)AccessBtnClick
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    HomePageViewController *HomeVC = [[HomePageViewController alloc]init];
    
    UINavigationController *homeGation = [[UINavigationController alloc]initWithRootViewController:HomeVC];
    window.rootViewController = homeGation;
    
}
@end
