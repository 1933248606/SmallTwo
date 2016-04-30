//
//  CustomButton.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/16.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "CustomButton.h"
#import "Tool_h.h"
@implementation CustomButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/13)];
    backImageView.image = [UIImage imageNamed:@"my_money_border"];
    [self addSubview:backImageView];
}


@end
