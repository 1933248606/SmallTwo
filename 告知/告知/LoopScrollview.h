//
//  LoopScrollview.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopScrollview : UIView
@property(strong,nonatomic,nullable)NSArray<UIImage*>*images;
//页面控制器用nullable？？？？？？？？
@property(weak,nonatomic,nullable)UIPageControl *pageControl;

@property(assign,nonatomic,getter=isScrollDirectionProtrait) BOOL scrollDirectionPortrait;

@end
