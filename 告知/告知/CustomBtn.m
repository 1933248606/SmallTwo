//
//  CustomBtn.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "CustomBtn.h"
#import "Masonry.h"
#import "Tool_h.h"



@implementation CustomBtn


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIImageView *ArrowImageView = [[UIImageView alloc]init];
    ArrowImageView.image = [UIImage imageNamed:@"nextstep_button"];
    [self addSubview:ArrowImageView];
    [ArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/18, WIDTH/18));
    }];
    UIImageView *bottomIV = [[UIImageView alloc]init];
    bottomIV.image = [UIImage imageNamed:@"bottom_line"];
    [self addSubview:bottomIV];
    [bottomIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.frame), 1));
    }];
    
}
/*
重写
 set
 get方法
 
*/

- (void)setTitle:(NSString *)title forState:(CustombuttonState)state
{
    
}

@end

