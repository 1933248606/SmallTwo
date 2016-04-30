//
//  RegisterVC.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/9.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *TopIV;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TelbackIV;
@property (weak, nonatomic) IBOutlet UIImageView *PswbackIV;
@property (weak, nonatomic) IBOutlet UIImageView *ConfirmbackIV;
@property (weak, nonatomic) IBOutlet UIImageView *SecuritybackIV;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PswLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConfirmLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecurityLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *PswTF;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmTF;
@property (weak, nonatomic) IBOutlet UITextField *SecurityTF;
@property (weak, nonatomic) IBOutlet UILabel *userProtocolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *protocol_darkIV;
@property (weak, nonatomic) IBOutlet UIImageView *protocol_highlightedIV;

@end
