//
//  Tool_h.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/15.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#ifndef Tool_h_h
#define Tool_h_h

//宏定义 alertView
#define SHOW_ALERT(info) UIAlertController  * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:UIAlertControllerStyleAlert];UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];[alertController addAction:alertAction];[self presentViewController:alertController animated:YES completion:nil];
//屏幕的宽度和高度
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define FIXED_HEIGHT 480
//调配的背景颜色
#define BackGroundColor(r, g, b, a) [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
#define HOST @"http://42.96.189.238:8080/weiad/comm"
#define TOP_BAR 64
#define FONT(x) [UIFont systemFontOfSize:x]
#define UserId @"userId"
#define USERNAME @"userName"
#define POINTS @"points"
#define ProvinceID @"provinceID"
#endif /* Tool_h_h */

