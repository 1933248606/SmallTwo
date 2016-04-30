//
//  QYFileButton.m
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/22.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "QYFileButton.h"

@implementation QYFileButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setButtonState:(QYInfoButtonState)buttonState
{
    buttonState = buttonState ;
    
    if (buttonState == QYInfoButtonStateNormal)
    {
        [self setTitle:@"修改资料" forState:UIControlStateNormal];
    }
    
    if (buttonState == QYInfoButtonStateSave)
    {
        [self setTitle:@"保存资料" forState:UIControlStateNormal];
    }
    
}

@end
