//
//  CertificationVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/21.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "CertificationVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "AuditVC.h"
#import "QYHttpRequest.h"
#import "RegionModel.h"
#import "MerchantModel.h"
#import "CitysModel.h"
@interface CertificationVC ()
{
    UIView *_backView;
    NSArray *MerchantsaArr;
    NSArray *BasicArr;
    NSArray *AddressArr;
    UILabel *label;
    UIButton *addPic;
}
@property (nonatomic, strong) NSArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSArray *districtArr;
@end

@implementation CertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIImageView *TopIV = [UIImageView new];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [UILabel new];
    TitleLabel.text = @"商铺认证";
    TitleLabel.textColor = [UIColor whiteColor];
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TOP_BAR+80, WIDTH, HEIGHT-TOP_BAR-140)];
    scr.contentSize = CGSizeMake(WIDTH, HEIGHT);
    scr.showsHorizontalScrollIndicator = NO;
    scr.showsVerticalScrollIndicator = NO;
    //scr.scrollEnabled = NO;
    //scr.bounces = NO;
    scr.scrollsToTop = NO;
    scr.userInteractionEnabled = YES;
    [self.view addSubview:scr];
    
    
    UILabel *chooseCityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, TOP_BAR, WIDTH, 40)];
    chooseCityLabel.text = @"  选择城市";
    chooseCityLabel.backgroundColor = BackGroundColor(230, 230, 230, 1);
    [_backView addSubview:chooseCityLabel];
    
    self.provinceComboBox = [[FYComboBox alloc]initWithFrame:CGRectMake(0, TOP_BAR+40, WIDTH/3, 40)];
    _provinceComboBox.delegate = self;
    _provinceComboBox.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_provinceComboBox];
    self.provinceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
    /*
    请求得到的省份
     */
    [QYHttpRequest requestProvinceInfo:^(NSArray *dataArray) {
        self.provinceArr = dataArray;
        _provinceLabel.text = _provinceArr[0];
    }];
    
    _provinceLabel.font = FONT(14);
    _provinceLabel.textColor = [UIColor grayColor];
    _provinceLabel.textAlignment = NSTextAlignmentCenter;
    [_provinceComboBox addSubview:_provinceLabel];
    
    self.cityComboBox = [[FYComboBox alloc]initWithFrame:CGRectMake(WIDTH/3+1, TOP_BAR+40, WIDTH/3, 40)];
    _cityComboBox.delegate = self;
    
    _cityComboBox.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cityComboBox];
    self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
    _cityLabel.text = @"长沙市";
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.textColor = [UIColor grayColor];
    [_cityComboBox addSubview:_cityLabel];
    
    self.districtComboBox = [[FYComboBox alloc]initWithFrame:CGRectMake(WIDTH/3*2+2, TOP_BAR+40, WIDTH/3, 40)];
    _districtComboBox.delegate = self;
    _districtComboBox.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_districtComboBox];
    self.districtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH/3, 40)];
    _districtLabel.text = @"开福区";
    _districtLabel.textAlignment = NSTextAlignmentCenter;
    _districtLabel.textColor = [UIColor grayColor];
    [_districtComboBox addSubview:_districtLabel];
    
    UILabel *basicInfoLabel = [[UILabel alloc]init];
    basicInfoLabel.text = @"  商家基本信息";
    basicInfoLabel.backgroundColor = BackGroundColor(230, 230, 230, 1);
    [scr addSubview:basicInfoLabel];
    
    [basicInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scr.mas_top);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    
    self.store_TF = [[UITextField alloc]init];
    _store_TF.placeholder = @"请输入店铺名称";
    [scr addSubview:_store_TF];
    [_store_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(basicInfoLabel.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    self.bussiness_TF = [[UITextField alloc]init];
    _bussiness_TF.placeholder = @"个人店铺所属行业";
    [scr addSubview:_bussiness_TF];
    [_bussiness_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_store_TF.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    self.legal_TF = [[UITextField alloc]init];
    _legal_TF.placeholder = @"请填写法人姓名";
    [scr addSubview:_legal_TF];
    [_legal_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bussiness_TF.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    self.phone_TF = [[UITextField alloc]init];
    _phone_TF.placeholder = @"请填写联系电话";
    [scr addSubview:_phone_TF];
    [_phone_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_legal_TF.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    self.address_TF = [[UITextField alloc]init];
    _address_TF.placeholder = @"请填写详细地址";
    [scr addSubview:_address_TF];
    [_address_TF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phone_TF.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];

    UILabel *uploadInfoLabel = [[UILabel alloc]init];
    uploadInfoLabel.text = @"  上传营业执照";
    uploadInfoLabel.backgroundColor = BackGroundColor(230, 230, 230, 1);
    [scr addSubview:uploadInfoLabel];
    
    [uploadInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_address_TF.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    addPic = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addPic.backgroundColor = [UIColor whiteColor];
    [addPic setTitle:@"添加图片" forState:(UIControlStateNormal)];
    [addPic addTarget:self action:@selector(addPicClick) forControlEvents:(UIControlEventTouchUpInside)];
    [scr addSubview:addPic];
    
    [addPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uploadInfoLabel.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 120));
    }];
    UILabel *companyDetailsLabel = [[UILabel alloc]init];
    companyDetailsLabel.text = @"  公司简介";
    companyDetailsLabel.backgroundColor = BackGroundColor(230, 230, 230, 1);
    [scr addSubview:companyDetailsLabel];
    
    [companyDetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addPic.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 40));
    }];
    self.detailsTV = [[UITextView alloc]init];
    _detailsTV.backgroundColor = [UIColor whiteColor];
    [scr addSubview:_detailsTV];
    [_detailsTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(companyDetailsLabel.mas_bottom);
        make.centerX.equalTo(scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 120));
    }];
    
    UIButton *SubmitBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [SubmitBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [SubmitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    SubmitBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [SubmitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [SubmitBtn addTarget:self action:@selector(SubmitClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_backView addSubview:SubmitBtn];
    
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(TopIV.mas_centerX);
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, HEIGHT/24));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [SubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backView.mas_bottom).with.offset(-20);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/12));
    }];
    self.cityArr = [NSMutableArray array];
    self.districtArr = @[@"开福区",@"雨花区",@"望城区",@"芙蓉广场",];
}
-(void)getindexCount:(NSInteger)row
{
    
}

#pragma mark FYComboBoxDelegate
//每个下拉菜单返回的个数
- (NSInteger)comboBoxNumberOfRows:(FYComboBox *)comboBox
{
    if (comboBox == self.provinceComboBox) {
        NSLog(@"请求获得到的省份%lu",(unsigned long)self.provinceArr.count);
        return self.provinceArr.count;
        
    } else if (comboBox == self.cityComboBox) {
        NSLog(@"请求获得到的对应的市区%lu",(unsigned long)self.cityArr.count);
        return self.cityArr.count;
        
    } else if (comboBox == self.districtComboBox) {
        return self.districtArr.count;
    }
    
    
    return 0;
}
//下拉菜单添加的内容
- (NSString *)comboBox:(FYComboBox *)comboBox titleForRow:(NSInteger)row
{
    if (comboBox == self.provinceComboBox) {
//        [QYHttpRequest requestProvinceInfo:^(NSArray *dataArray) {
//            self.provinceArr = dataArray;
//            _provinceLabel.text = _provinceArr[0];
//        }];
        
        return self.provinceArr[row];
        
    } else if (comboBox == self.cityComboBox) {
//        RegionModel *regionmodel = [[RegionModel alloc]init];
//        NSString *str = [NSString stringWithFormat:@"%ld",(long)row];
//        regionmodel.ProID = str;
//        [QYHttpRequest requestCityInfo:regionmodel WithBlock:^(NSArray *dataArray) {
//            [self.cityArr addObject:dataArray];
//            NSLog(@"每个下拉菜单返回的个数%@",self.cityArr);
//        }];

        
        return self.cityArr[row];
        
    } else if (comboBox == self.districtComboBox) {
        return self.districtArr[row];
    }
    
    return 0;
}
//选中的城市
- (void)comboBox:(FYComboBox *)comboBox didSelectRow:(NSInteger)row
{
    if (comboBox == self.provinceComboBox) {
        RegionModel *regionmodel = [[RegionModel alloc]init];
        NSString *str = [NSString stringWithFormat:@"%ld",(long)row];
        regionmodel.ProID = str;
        [QYHttpRequest requestCityInfo:regionmodel WithBlock:^(NSArray *dataArray) {
            
            
            [self.cityArr addObject:dataArray];
            NSLog(@"选中以后返回的城市%@",dataArray);
        }];

    self.provinceLabel.text = self.provinceArr[row];
        
    } else if (comboBox == self.cityComboBox) {
        
        NSLog(@"Selected %@", self.cityArr[row]);
        self.cityLabel.text = self.cityArr[row];
        
    } else if (comboBox == self.districtComboBox) {
        self.districtLabel.text = self.districtArr[row];
    }
    
    [comboBox closeAnimated:YES];
}

-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//上传营业执照
-(void)addPicClick
{
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"选择了图片");
    [addPic setBackgroundImage:image forState:(UIControlStateNormal)];
    //[self saveImage:image WithName:@"HeadPic"];
    QYUser *user = [[QYUser alloc]init];
    NSData *headimgdata = UIImagePNGRepresentation(image);
    NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
    
    user.userId = userId;
    NSString *typeStr = [NSString stringWithFormat:@"%@",@1];
    user.type = typeStr;
    user.imgdata = headimgdata;
    [QYHttpRequest uploadUserHeadPic:user completion:^(NSString *error, BOOL isSuccess) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];//返回
}

//提交认证信息
-(void)SubmitClick
{
    AuditVC *auditVC = [[AuditVC alloc]init];
    [self.navigationController pushViewController:auditVC animated:YES];
    MerchantModel *model = [[MerchantModel alloc]init];
    NSString *userid = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
    model.userId = userid;
    model.lawyer_name = _legal_TF.text;
    model.merchantName = _store_TF.text;
    model.merchantBusiness = _bussiness_TF.text;
    model.merchantPhone = _phone_TF.text;
    model.merchantInfo = _detailsTV.text;
    model.merchantAddress = _address_TF.text;
    model.baseAddress = @"基础地址";
    model.business_license_photo = @"营业执照资源key";
    [QYHttpRequest merchantOfcertification:model];
    
    
}
//-(void)addressClick:(UIButton*)btn
//{
//    if (btn.tag == 10)
//    {
//        NSLog(@"10");
//    }
//    if (btn.tag == 11)
//    {
//        NSLog(@"11");
//    }if (btn.tag == 12)
//    {
//        NSLog(@"12");
//    }
//}
//-(void)UploadClick
//{
//    
//}

@end
