//
//  MerchantAdvTVCell.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/23.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "MerchantAdvTVCell.h"
#import "PayAdvVC.h"

@implementation MerchantAdvTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goPaymentBtn:(id)sender {
    PayAdvVC *payadvVC = [[PayAdvVC alloc]init];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    window.rootViewController = payadvVC;
}

@end
