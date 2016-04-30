//
//  ReleaseGraphic.m
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/28.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ReleaseGraphic.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "PayAdvVC.h"

@interface ReleaseGraphic ()
{
    UIButton *endTimeBtn;
    BOOL isChange;
    UIDatePicker  *datePicker;
    UIScrollView  *_scr;
    UIView *dateView;
    UIButton *uploadBtn;
}
@end

@implementation ReleaseGraphic

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [self.view addSubview:TopIV];
    
    _scr = [[UIScrollView alloc]init];
    _scr.contentSize = CGSizeMake(WIDTH, HEIGHT);
    _scr.backgroundColor = BackGroundColor(240, 240, 240, 1);
    _scr.showsHorizontalScrollIndicator = NO;
    _scr.showsVerticalScrollIndicator = NO;
    _scr.scrollEnabled = NO;
    _scr.bounces = NO;
    _scr.scrollsToTop = NO;
    _scr.userInteractionEnabled = YES;
    [self.view addSubview:_scr];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"发布广告";
    TitleLabel.font = [UIFont systemFontOfSize:20];
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TopIV addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scr.mas_centerX);
        make.top.equalTo(self.view.mas_top);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [_scr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.left.equalTo(TopIV.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 25));
    }];
    
    UITextField *TitleTF = [[UITextField alloc]init];
    TitleTF.placeholder = @"  请输入广告标题";
    TitleTF.backgroundColor = [UIColor whiteColor];
    TitleTF.delegate = self;
    [_scr addSubview:TitleTF];
    [TitleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scr.mas_top);
        make.centerX.equalTo(_scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    UIView *uploadView = [[UIView alloc]init];
    uploadView.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:uploadView];
    
    UILabel *uploadlabel = [[UILabel alloc]init];
    uploadlabel.text = @"上传封面图片";
    uploadlabel.textColor = BackGroundColor(220, 220, 220, 1);
    [uploadView addSubview:uploadlabel];
    
    uploadBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [uploadBtn setBackgroundImage:[UIImage imageNamed:@"add_-picture_03"] forState:(UIControlStateNormal)];
    [uploadBtn addTarget:self action:@selector(uploadPicClick) forControlEvents:(UIControlEventTouchUpInside)];
    [uploadView addSubview:uploadBtn];
    
    [uploadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TitleTF.mas_bottom).with.offset(1);
        make.centerX.equalTo(_scr.mas_centerX);
        make.size.mas_offset(CGSizeMake(WIDTH, 80));
    }];
    [uploadlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(uploadView.mas_centerY);
        make.left.equalTo(uploadView.mas_left).with.offset(20);
        make.height.mas_offset(20);
    }];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(uploadView.mas_centerY);
        make.left.equalTo(uploadlabel.mas_right).with.offset(30);
        make.size.mas_offset(CGSizeMake(75, 75));
    }];
    //富文本编辑器的使用
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadView.mas_bottom).with.offset(1);
        make.centerX.equalTo(_scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 140));
    }];
    
    UILabel *goods_link = [[UILabel alloc]init];
    goods_link.text = @"  添加商品链接:";
    goods_link.font = FONT(14);
    goods_link.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:goods_link];
    [goods_link mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).with.offset(1);
        make.left.equalTo(_scr.mas_left);
        make.size.mas_offset(CGSizeMake(WIDTH/3, 40));
    }];
    UIButton *addlinkBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [addlinkBtn setBackgroundImage:[UIImage imageNamed:@"add_more_02"] forState:(UIControlStateNormal)];
    [addlinkBtn addTarget:self action:@selector(addlinkClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:addlinkBtn];
    
    [addlinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_top);
        make.right.equalTo(_scr.mas_right);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    UITextField *link_TF = [[UITextField alloc]init];
    link_TF.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:link_TF];
    [link_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_top);
        make.left.equalTo(goods_link.mas_right);
        make.right.equalTo(addlinkBtn.mas_left);
        make.height.mas_offset(40);
    }];
    
    UILabel * unitPriceLabel = [UILabel new];
    unitPriceLabel.text = @"单价";
    unitPriceLabel.textAlignment = NSTextAlignmentCenter;
    unitPriceLabel.font = [UIFont systemFontOfSize:14];
    unitPriceLabel.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:unitPriceLabel];
    [unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(_scr.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UITextField *unitPriceTF = [UITextField new];
    unitPriceTF.placeholder = @"0.01-1.00";
    unitPriceTF.font = [UIFont systemFontOfSize:12];
    unitPriceTF.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:unitPriceTF];
    [unitPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(unitPriceLabel.mas_right).with.offset(1);
        make.height.mas_equalTo(40);
    }];
    UILabel *rmbLabel = [UILabel new];
    rmbLabel.text = @"元";
    rmbLabel.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:rmbLabel];
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(unitPriceTF.mas_right);
        make.height.mas_equalTo(40);
    }];
    UILabel *grossLabel = [[UILabel alloc]init];
    grossLabel.text = @"总量";
    grossLabel.textAlignment = NSTextAlignmentCenter;
    grossLabel.font = [UIFont systemFontOfSize:14];
    grossLabel.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:grossLabel];
    [grossLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(rmbLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UITextField *grossTF = [[UITextField alloc]init];
    grossTF.placeholder = @"不限";
    grossTF.font = [UIFont systemFontOfSize:14];
    grossTF.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:grossTF];
    [grossTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(grossLabel.mas_right).with.offset(1);
        make.right.equalTo(_scr.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UILabel *promotionAreaLabel = [[UILabel alloc]init];
    promotionAreaLabel.text = @"推广区域";
    promotionAreaLabel.textAlignment = NSTextAlignmentCenter;
    promotionAreaLabel.font = [UIFont systemFontOfSize:14];
    promotionAreaLabel.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:promotionAreaLabel];
    [promotionAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitPriceLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_scr.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UIButton *chooseAreaBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [chooseAreaBtn setBackgroundColor:[UIColor whiteColor]];
    chooseAreaBtn.titleLabel.font = FONT(14);
    [chooseAreaBtn setTitle:@"区域省市县" forState:(UIControlStateNormal)];
    [chooseAreaBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [chooseAreaBtn addTarget:self action:@selector(ChooseAreaClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:chooseAreaBtn];
    [chooseAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitPriceLabel.mas_bottom).with.offset(1);
        make.left.equalTo(promotionAreaLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4*2, 40));
    }];
    
    UIButton *chooseClassifyBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    chooseClassifyBtn.backgroundColor = [UIColor whiteColor];
    chooseAreaBtn.titleLabel.font = FONT(14);
    [chooseClassifyBtn setTitle:@"选择分类" forState:(UIControlStateNormal)];
    [chooseClassifyBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [chooseClassifyBtn addTarget:self action:@selector(ChooseClassifyClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:chooseClassifyBtn];
    [chooseClassifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_top);
        make.left.equalTo(chooseAreaBtn.mas_right).with.offset(1);
        make.right.equalTo(_scr.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * endTimeLabel = [UILabel new];
    endTimeLabel.text = @"截止时间";
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    endTimeLabel.font = [UIFont systemFontOfSize:14];
    endTimeLabel.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:endTimeLabel];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_bottom).with.offset(1);
        make.left.equalTo(_scr.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    endTimeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    endTimeBtn.backgroundColor = [UIColor whiteColor];
    [endTimeBtn setTitle:@"具体的年月日" forState:(UIControlStateNormal)];
    [endTimeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [endTimeBtn addTarget:self action:@selector(endTimeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:endTimeBtn];
    [endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_bottom).with.offset(1);
        make.left.equalTo(endTimeLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4*3, 40));
    }];
    /*
     时间选择器，选择任务的截止时间
     
     */
    dateView = [[UIView alloc]init];
    dateView.backgroundColor = [UIColor whiteColor];
    [_scr addSubview:dateView];
    isChange = NO;
    dateView.hidden = YES;
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_scr);
        make.size.mas_offset(CGSizeMake(WIDTH, 80));
    }];

    datePicker =[[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(selectDate:) forControlEvents:(UIControlEventValueChanged)];
    [dateView addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dateView);
        make.size.equalTo(dateView);
    }];
    
    
    UIButton *calculatePriceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    calculatePriceBtn.layer.masksToBounds = YES;
    calculatePriceBtn.layer.cornerRadius = 6;
    [calculatePriceBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [calculatePriceBtn setTitle:@"计算价格" forState:(UIControlStateNormal)];
    calculatePriceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [calculatePriceBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [calculatePriceBtn addTarget:self action:@selector(calculatePriceClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:calculatePriceBtn];
    [calculatePriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endTimeLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(_scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-20, 40));
    }];
    
}
//上传广告封面图片
-(void)uploadPicClick {
        //NSLog(@"%@",NSHomeDirectory());
        //图片选择视图管理器
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        //设置打开的类型(测试系统内没有 SourceTypeCamera 类型)
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            NSLog(@"当前设备不支持相机模式");
        }
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate =self;
        //设置图片是否可编辑
        pick.allowsEditing =YES;
        [self presentViewController:pick animated:YES completion:nil];
        
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
        NSLog(@"选择了图片");
        [uploadBtn setBackgroundImage:image forState:(UIControlStateNormal)];
        //[self saveImage:image WithName:@"HeadPic"];
        //QYUser *user = [[QYUser alloc]init];
        //NSData *headimgdata = UIImagePNGRepresentation(image);
//        NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
//        
//        user.userId = userId;
//        NSString *typeStr = [NSString stringWithFormat:@"%@",@1];
//        user.type = typeStr;
//        user.imgdata = headimgdata;
//        [QYHttpRequest uploadUserHeadPic:user completion:^(NSString *error, BOOL isSuccess) {
//            
//        }];
        [self dismissViewControllerAnimated:YES completion:nil];//返回
}
//添加商品链接
-(void)addlinkClick
{
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- ChooseArea
//选择发布区域
-(void)ChooseAreaClick
{
    
}
//选择广告分类
-(void)ChooseClassifyClick
{
    
}
//选择截止时间
-(void)endTimeClick
{
    if (isChange == NO) {
        dateView.hidden = NO;
        isChange = YES;
    }
    else{
        dateView.hidden = YES;
        isChange = NO;
    }
}
-(void)selectDate:(UIDatePicker*)datepicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy--MM--dd"];
    NSString *date = [formatter stringFromDate:datepicker.date];
    [endTimeBtn setTitle:date forState:(UIControlStateNormal)];
}

//计算广告的总价
-(void)calculatePriceClick
{
    PayAdvVC *payAdvVC = [[PayAdvVC alloc]init];
    [self.navigationController pushViewController:payAdvVC animated:YES];
}
/*
当标题输入框开始输入时，滚动视图向上移动
*/
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _scr.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _scr.contentSize = CGSizeMake(WIDTH, HEIGHT+216);
    _scr.scrollEnabled = YES;
}

@end
