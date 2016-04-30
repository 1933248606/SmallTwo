//
//  QYFileButton.h
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/22.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,QYInfoButtonState)
{
    QYInfoButtonStateNormal = 0,//
    QYInfoButtonStateSave
};
@interface QYFileButton : UIButton
@property(nonatomic,assign)QYInfoButtonState buttonState ;
@end
