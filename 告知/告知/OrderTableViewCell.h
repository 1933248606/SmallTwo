//
//  OrderTableViewCell.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/24.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
- (IBAction)userHeadBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *advTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quotaLabel;
@property (weak, nonatomic) IBOutlet UILabel *hitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *advPic_first;
@property (weak, nonatomic) IBOutlet UILabel *univalenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *univalence_RMB_Label;
@property (weak, nonatomic) IBOutlet UILabel *company_NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *divider_IV;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *advDetailslabel;
@property (weak, nonatomic) IBOutlet UIImageView *certificationIcon;

@end
