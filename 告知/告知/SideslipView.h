//
//  SideslipView.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/7.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlideslipDelegate;
@protocol SlideslipDelegate <NSObject>

-(void)delegateClick:(int)buttonTag;
@end;

@interface SideslipView : UIView
@property(strong,nonatomic)UIImageView *HeadIV;
@property(strong,nonatomic)UILabel *user_NameLabel;
@property(strong,nonatomic)UILabel *integral_CountLabel;


@property(strong,nonatomic)id<SlideslipDelegate>delegate;

@end
