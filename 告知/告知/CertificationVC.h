//
//  CertificationVC.h
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/21.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYComboBox.h"

@interface CertificationVC : UIViewController<FYComboBoxDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)FYComboBox *provinceComboBox;
@property(nonatomic,strong)FYComboBox *cityComboBox;
@property(nonatomic,strong)FYComboBox *districtComboBox;
@property(nonatomic,strong)UILabel *provinceLabel;
@property(nonatomic,strong)UILabel *cityLabel;
@property(nonatomic,strong)UILabel *districtLabel;
@property(nonatomic,strong)UITextField *store_TF;
@property(nonatomic,strong)UITextField *bussiness_TF;
@property(nonatomic,strong)UITextField *legal_TF;
@property(nonatomic,strong)UITextField *phone_TF;
@property(nonatomic,strong)UITextField *address_TF;
@property(nonatomic,strong)UITextView *detailsTV;

@end
