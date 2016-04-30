//
//  ShareCustomView.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/23.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ShareCustomView.h"
#import "Tool_h.h"
@implementation ShareCustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UILabel *ShareLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-WIDTH/10, HEIGHT/48, WIDTH/5, HEIGHT/22)];
    ShareLabel.text = @"分享到";
    ShareLabel.font = [UIFont systemFontOfSize:16];
    ShareLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ShareLabel];
    
    IconArr = @[@"icon_weibo",@"icon_weixin",@"icon_Circleoffriends",@"icon_qq",@"icon_QQkongjian",];
    TitleArr = @[@"微博",@"微信",@"朋友圈",@"QQ",@"QQ空间",];
    for (int i = 0; i < 5; i++)
    {
        UIButton *ShareButton = [[UIButton alloc]initWithFrame:CGRectMake(15+(WIDTH-WIDTH/10*5)/5*i+WIDTH/10*i, 65, WIDTH/10, WIDTH/10)];
        [ShareButton setBackgroundImage:[UIImage imageNamed:[IconArr objectAtIndex:i]] forState:(UIControlStateNormal)];
        [ShareButton addTarget:self action:@selector(ShareClick:) forControlEvents:(UIControlEventTouchUpInside)];
        ShareButton.tag = i+1;
        [self addSubview:ShareButton];
        
        
        UILabel *ShareTitle = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/32+(WIDTH-WIDTH/6)/5*i+WIDTH/32*i, HEIGHT/4.3, WIDTH/7, 20)];
        ShareTitle.text = [TitleArr objectAtIndex:i];
        ShareTitle.textAlignment = NSTextAlignmentCenter;
        ShareTitle.font = [UIFont systemFontOfSize:12];
        [self addSubview:ShareTitle];
    }
    
    UIButton *CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-WIDTH/16, HEIGHT/3, WIDTH/8, WIDTH/10)];
    [CancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [CancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [CancelButton addTarget:self action:@selector(CancelClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:CancelButton];
    
}
-(void)CancelClick
{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(ViewDissMiss:)])
    {
        [_delegate ViewDissMiss:self];
    }

    NSLog(@"取消");
}
-(void)ShareClick:(UIButton*)button;
{
    switch (button.tag) {
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
            break;
        case 4:
            NSLog(@"4");
            break;
        case 5:
            NSLog(@"5");
            break;
        default:
            break;
    }
}
@end
