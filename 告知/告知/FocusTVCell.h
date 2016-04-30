//
//  FocusTVCell.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/15.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadPic;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *focusMarkIV;

@end
