//
//  HotAdvTableViewCell.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotAdvTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HotAdvIV;
@property (weak, nonatomic) IBOutlet UILabel *HotAdvTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *HotAdvPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *HotAdvUnitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *NatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *TaskLoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *SpotCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *KeywordLabel;
@property (weak, nonatomic) IBOutlet UILabel *KeywordInfoLabel;

@end
