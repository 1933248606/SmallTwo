//
//  ReleaseVideoVC.m
//  告知
//
//  Created by 不忘初心方得始终 on 16/4/28.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "ReleaseVideoVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "PayAdvVC.h"
@interface ReleaseVideoVC ()
{
    UIView *_backView;
    UIButton *endTimeBtn;
    BOOL isChange;
    UIDatePicker  *datePicker;
}
@end

@implementation ReleaseVideoVC

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
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
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
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
    [_backView addSubview:TitleTF];
    [TitleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopIV.mas_bottom);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    //富文本编辑器的使用
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TitleTF.mas_bottom).with.offset(1);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 200));
    }];
    
    UIButton *uploadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [uploadBtn setTitle:@"上传视频" forState:(UIControlStateNormal)];
    [uploadBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [uploadBtn setImage:[UIImage imageNamed:@"icon_uploading"] forState:(UIControlStateNormal)];
    [uploadBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 10, 0, 0))];
    [uploadBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, 5, 5, 30))];
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [uploadBtn addTarget:self action:@selector(uploadClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:uploadBtn];
    [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textView.mas_bottom).with.offset(-5);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];

    
    self.goods_link = [[UILabel alloc]init];
    _goods_link.text = @"  添加商品链接";
    _goods_link.font = FONT(14);
    _goods_link.textColor = [UIColor grayColor];
    _goods_link.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_goods_link];
    [_goods_link mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    
    UILabel * unitPriceLabel = [UILabel new];
    unitPriceLabel.text = @"单价";
    unitPriceLabel.textAlignment = NSTextAlignmentCenter;
    unitPriceLabel.font = [UIFont systemFontOfSize:14];
    unitPriceLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:unitPriceLabel];
    [unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UITextField *unitPriceTF = [UITextField new];
    unitPriceTF.placeholder = @"0.01-1.00";
    unitPriceTF.font = [UIFont systemFontOfSize:12];
    unitPriceTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:unitPriceTF];
    [unitPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(unitPriceLabel.mas_right).with.offset(1);
        make.height.mas_equalTo(40);
    }];
    UILabel *rmbLabel = [UILabel new];
    rmbLabel.text = @"元";
    rmbLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:rmbLabel];
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(unitPriceTF.mas_right);
        make.height.mas_equalTo(40);
    }];
    UILabel *grossLabel = [[UILabel alloc]init];
    grossLabel.text = @"总量";
    grossLabel.textAlignment = NSTextAlignmentCenter;
    grossLabel.font = [UIFont systemFontOfSize:14];
    grossLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:grossLabel];
    [grossLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(rmbLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UITextField *grossTF = [[UITextField alloc]init];
    grossTF.placeholder = @"不限";
    grossTF.font = [UIFont systemFontOfSize:14];
    grossTF.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:grossTF];
    [grossTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goods_link.mas_bottom).with.offset(1);
        make.left.equalTo(grossLabel.mas_right).with.offset(1);
        make.right.equalTo(_backView.mas_right);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UILabel *promotionAreaLabel = [[UILabel alloc]init];
    promotionAreaLabel.text = @"推广区域";
    promotionAreaLabel.textAlignment = NSTextAlignmentCenter;
    promotionAreaLabel.font = [UIFont systemFontOfSize:14];
    promotionAreaLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:promotionAreaLabel];
    [promotionAreaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitPriceLabel.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    UIButton *chooseAreaBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [chooseAreaBtn setBackgroundColor:[UIColor whiteColor]];
    [chooseAreaBtn setTitle:@"区域省市县" forState:(UIControlStateNormal)];
    [chooseAreaBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [chooseAreaBtn addTarget:self action:@selector(ChooseAreaClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:chooseAreaBtn];
    [chooseAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(unitPriceLabel.mas_bottom).with.offset(1);
        make.left.equalTo(promotionAreaLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4*2, 40));
    }];
    
    UIButton *chooseClassifyBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    chooseClassifyBtn.backgroundColor = [UIColor whiteColor];
    [chooseClassifyBtn setTitle:@"选择分类" forState:(UIControlStateNormal)];
    [chooseClassifyBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    [chooseClassifyBtn addTarget:self action:@selector(ChooseClassifyClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:chooseClassifyBtn];
    [chooseClassifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_top);
        make.left.equalTo(chooseAreaBtn.mas_right).with.offset(1);
        make.right.equalTo(_backView.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    UILabel * endTimeLabel = [UILabel new];
    endTimeLabel.text = @"截止时间";
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    endTimeLabel.font = [UIFont systemFontOfSize:14];
    endTimeLabel.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:endTimeLabel];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_bottom).with.offset(1);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 40));
    }];
    endTimeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    endTimeBtn.backgroundColor = [UIColor whiteColor];
    [endTimeBtn setTitle:@"具体的年月日" forState:(UIControlStateNormal)];
    [endTimeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [endTimeBtn addTarget:self action:@selector(endTimeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:endTimeBtn];
    [endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseAreaBtn.mas_bottom).with.offset(1);
        make.left.equalTo(endTimeLabel.mas_right).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4*3, 40));
    }];
    
    datePicker =[[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(selectDate:) forControlEvents:(UIControlEventValueChanged)];
    datePicker.hidden = YES;
    [_backView addSubview:datePicker];
    isChange = NO;
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.mas_centerX);
        make.top.equalTo(endTimeBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 100));
    }];
    
    
    UIButton *calculatePriceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    calculatePriceBtn.layer.masksToBounds = YES;
    calculatePriceBtn.layer.cornerRadius = 6;
    [calculatePriceBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [calculatePriceBtn setTitle:@"计算价格" forState:(UIControlStateNormal)];
    calculatePriceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [calculatePriceBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [calculatePriceBtn addTarget:self action:@selector(calculatePriceClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:calculatePriceBtn];
    [calculatePriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backView.mas_bottom).with.offset(-20);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-20, 40));
    }];

}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
上传视频
*/
-(void)uploadClick
{
    
}
#pragma mark -- ChooseArea
//选择区域
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
        datePicker.hidden = NO;
        isChange = YES;
    }
    else{
        datePicker.hidden = YES;
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

@end
