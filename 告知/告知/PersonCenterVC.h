//
//  PersonCenterVC.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/13.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountVC.h"
#import "ApproveVC.h"
#import "QYFileButton.h"
#import "QYHttpRequest.h"
#import "QYUser.h"
#import "Interface.h"
@interface PersonCenterVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    NSArray  *nameArr;
    AccountVC *accountVC;
    UIButton *alter_HeadPic;
    BOOL     isChange;
    UIScrollView *_scr;
    UIView *backView;
}

@property(nonatomic,retain)UITextField *editTF_nick;
@property(nonatomic,retain)UITextField *editTF_sex;
@property(nonatomic,retain)UITextField *editTF_age;
@property(nonatomic,retain)UITextField *editTF_address;
@property(nonatomic,retain)UITextField *editTF_email;
@property(nonatomic,retain)UITextField *editTF_industry;
@property(nonatomic,retain)UITextField *editTF_company;
@property(nonatomic,retain)UITextField *editTF_link;
@property(nonatomic,retain)UITextField *editTF_info;
@property(nonatomic,retain)UILabel *integral_countLabel;
@end
