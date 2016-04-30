//
//  SpotButton.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/28.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "SpotButton.h"
#import "Masonry.h"
#import "Tool_h.h"
@implementation SpotButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT/13)];
    backIV.image = [UIImage imageNamed:@"my_money_border"];
    backIV.userInteractionEnabled = YES;
    [self addSubview:backIV];
    UIImageView *DropIV = [UIImageView new];
    DropIV.image = [UIImage imageNamed:@"drop_down_choice"];
    DropIV.userInteractionEnabled = YES;
    [self addSubview:DropIV];
    [DropIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backIV.mas_centerY);
        make.right.equalTo(backIV.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
}


@end
