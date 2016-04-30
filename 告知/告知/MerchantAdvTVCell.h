//
//  MerchantAdvTVCell.h
//  Demo1   layer.masksToBounds layer.cornerRadius
//
//  Created by 不忘初心方得始终 on 16/3/23.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertisingVC.h"
@interface MerchantAdvTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeadPic;
@property (weak, nonatomic) IBOutlet UILabel *merchantAdvNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *certificationIcon;
@property (weak, nonatomic) IBOutlet UILabel *advStateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dividerIV;
@property (weak, nonatomic) IBOutlet UIImageView *advIconIV;
@property (weak, nonatomic) IBOutlet UILabel *advTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quotaLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *completenessLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dividerIV_CentreIV;
@property (weak, nonatomic) IBOutlet UILabel *hitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *univalenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *univalence_RMB_Label;
@property (weak, nonatomic) IBOutlet UIImageView *bottom_lineIV;

@end
