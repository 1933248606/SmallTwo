//
//  ShareCustomView.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/23.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCustomView : UIView

{
    NSArray *IconArr;
    NSArray *TitleArr;
}
@property(nonatomic,weak)id delegate;
@end

@protocol ShareDelegate <NSObject>
@optional
-(void)ViewDissMiss:(UIView*)bgView;

@end