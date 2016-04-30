//
//  FeedbackView.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/29.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoreVCDelegate;
@protocol MoreVCDelegate <NSObject>

-(void)ClickDismissView:(int)button;

@end

@interface FeedbackView : UIView
@property(weak,nonatomic)id<MoreVCDelegate>delegate;
@end
