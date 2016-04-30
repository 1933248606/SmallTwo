//
//  HighestPriceAdvTVCell.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighestPriceAdvTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Sequence_IV;
@property (weak, nonatomic) IBOutlet UILabel *univalenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *univalence_RMBLabel;
@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *advPic_IV;
@property (weak, nonatomic) IBOutlet UILabel *advTitle_Label;
@property (weak, nonatomic) IBOutlet UILabel *advActivity_Label;
@property (weak, nonatomic) IBOutlet UILabel *taskload_Label;
@property (weak, nonatomic) IBOutlet UILabel *taskload_countLabel;
@property (weak, nonatomic) IBOutlet UILabel *click_Label;
@property (weak, nonatomic) IBOutlet UILabel *endtime_Label;
@property (weak, nonatomic) IBOutlet UILabel *time_Label;

@property (weak, nonatomic) IBOutlet UIImageView *bottom_lineIV;

@end
