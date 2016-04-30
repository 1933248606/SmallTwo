//
//  CustomBtn.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CustombuttonState) {
    
    CustombuttonStateNormal = 1,
};
@interface CustomBtn : UIButton
{
    UILabel *_stateLabel;
}
- (void)setTitle:(NSString *)title forState:(CustombuttonState)state;

@end
