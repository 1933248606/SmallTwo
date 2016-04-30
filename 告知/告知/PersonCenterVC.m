//
//  PersonCenterVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/4/13.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "PersonCenterVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "QYHttpRequest.h"
#import "QYUser.h"
#import "QueryUserInfo.h"
@interface PersonCenterVC ()
{
    NSString* fullPathToFile;
}
@end

@implementation PersonCenterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:backView];
    
    _scr = [[UIScrollView alloc]init];
    _scr.contentSize = CGSizeMake(WIDTH, HEIGHT);
    _scr.showsHorizontalScrollIndicator = NO;
    _scr.showsVerticalScrollIndicator = NO;
    _scr.scrollEnabled = NO;
    _scr.bounces = NO;
    _scr.scrollsToTop = NO;
    _scr.userInteractionEnabled = YES;
    [self.view addSubview:_scr];
    
    UIImageView *topIV = [[UIImageView alloc]init];
    topIV.image = [UIImage imageNamed:@"banner"];
    topIV.userInteractionEnabled = YES;
    [_scr addSubview:topIV];
    
    UIButton *returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 5, 0)];
    [returnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:returnBtn];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"HeadPic"];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:fullPath];
    alter_HeadPic = [UIButton buttonWithType:(UIButtonTypeSystem)];
    if (!savedImage) {
        [alter_HeadPic setBackgroundImage:[UIImage imageNamed:@"my_Headportrait"] forState:(UIControlStateNormal)];
    }
    else{
        [alter_HeadPic setBackgroundImage:savedImage forState:(UIControlStateNormal)];
    }
    alter_HeadPic.layer.masksToBounds = YES;
    alter_HeadPic.layer.cornerRadius = WIDTH/10;
    [alter_HeadPic addTarget:self action:@selector(alterHeadClick) forControlEvents:(UIControlEventTouchUpInside)];
    [topIV addSubview:alter_HeadPic];
    
    UILabel *integralLabel = [[UILabel alloc]init];
    integralLabel.text = @"积分：";
    integralLabel.textColor = [UIColor whiteColor];
    [topIV addSubview:integralLabel];
    
    self.integral_countLabel = [[UILabel alloc]init];
    _integral_countLabel.text = @"1000";
    _integral_countLabel.textColor = [UIColor whiteColor];
    [topIV addSubview:_integral_countLabel];
    
    [_scr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [topIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scr.mas_top);
        make.centerX.equalTo(_scr.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT/5));
    }];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scr.mas_top).with.offset(WIDTH/15);
        make.left.equalTo(_scr.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [alter_HeadPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topIV.mas_centerX);
        make.centerY.equalTo(topIV.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, WIDTH/5));
    }];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(alter_HeadPic.mas_centerX);
        make.top.equalTo(alter_HeadPic.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
    [_integral_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(integralLabel.mas_top);
        make.left.equalTo(integralLabel.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    nameArr = @[@"昵称:",@"性别:",@"年龄:",@"所在地:",@"邮箱:",@"行业:",@"公司:",@"商家网址:",@"简介:",];
    for (int i = 0; i < 9; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT/5+40*i, WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [_scr addSubview:view];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.text = [nameArr objectAtIndex:i];
        [view addSubview:nameLabel];
        
        UIImageView *bottom_line = [[UIImageView alloc]init];
        bottom_line.image = [UIImage imageNamed:@"bottom_line.png"];
        bottom_line.backgroundColor = [UIColor orangeColor];
        [view addSubview:bottom_line];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view.mas_centerY);
            make.left.equalTo(view.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        [bottom_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.top.equalTo(view.mas_top).with.offset(39);
            make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
        }];
    }
    self.editTF_nick = [[UITextField alloc]init];
    //editTF_nick.backgroundColor = [UIColor grayColor];
    _editTF_nick.delegate = self;
    _editTF_nick.text = @"文本内容";
    _editTF_nick.clearsOnBeginEditing = NO;
    [_scr addSubview:_editTF_nick];
    
    [_editTF_nick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIV.mas_bottom).with.offset(5);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    
    self.editTF_sex = [[UITextField alloc]init];
    _editTF_sex.backgroundColor = [UIColor whiteColor];
    _editTF_sex.delegate = self;
    [_scr addSubview:_editTF_sex];
    
    
    [_editTF_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_nick.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    
    self.editTF_age = [[UITextField alloc]init];
    _editTF_age.backgroundColor = [UIColor whiteColor];
    _editTF_age.delegate = self;
    [_scr addSubview:_editTF_age];
    
    
    [_editTF_age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_sex.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_address = [[UITextField alloc]init];
    _editTF_address.backgroundColor = [UIColor whiteColor];
    _editTF_address.delegate = self;
    [_scr addSubview:_editTF_address];
    
    
    [_editTF_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_age.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_email = [[UITextField alloc]init];
    _editTF_email.backgroundColor = [UIColor whiteColor];
    _editTF_email.delegate = self;
    [_scr addSubview:_editTF_email];
    
    
    [_editTF_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_address.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_industry = [[UITextField alloc]init];
    _editTF_industry.backgroundColor = [UIColor whiteColor];
    _editTF_industry.delegate = self;
    [_scr addSubview:_editTF_industry];
    
    [_editTF_industry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_email.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_company = [[UITextField alloc]init];
    _editTF_company.backgroundColor = [UIColor whiteColor];
    _editTF_company.delegate = self;
    [_scr addSubview:_editTF_company];
    
    [_editTF_company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_industry.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_link = [[UITextField alloc]init];
    _editTF_link.backgroundColor = [UIColor whiteColor];
    _editTF_link.delegate = self;
    [_scr addSubview:_editTF_link];
    
    [_editTF_link mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_company.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    self.editTF_info = [[UITextField alloc]init];
    _editTF_info.backgroundColor = [UIColor whiteColor];
    _editTF_info.delegate = self;
    [_scr addSubview:_editTF_info];
    
    [_editTF_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_link.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
    }];
    
    QYFileButton *editDataBtn = [QYFileButton buttonWithType:(UIButtonTypeSystem)];
    editDataBtn.layer.borderWidth = 1;
    editDataBtn.layer.masksToBounds = YES;
    editDataBtn.layer.cornerRadius = 4;
    [editDataBtn setTitle:@"编辑资料" forState:(UIControlStateNormal)];
    editDataBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [editDataBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [editDataBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    editDataBtn.tag = 1;
    [_scr addSubview:editDataBtn];
    
    QYFileButton *saveBtn = [QYFileButton buttonWithType:(UIButtonTypeSystem)];
    saveBtn.layer.borderWidth = 1;
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 4;
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    saveBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [saveBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [saveBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    saveBtn.tag = 2;
    [_scr addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIV.mas_top).with.offset(20);
        make.right.equalTo(topIV.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    UIButton *accountBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    accountBtn.layer.masksToBounds= YES;
    accountBtn.backgroundColor = [UIColor redColor];
    accountBtn.layer.cornerRadius = 4;
    [accountBtn setTitle:@"账号管理" forState:(UIControlStateNormal)];
    [accountBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [accountBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [accountBtn addTarget:self action:@selector(accountBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:accountBtn];
    
    [editDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_info.mas_bottom).with.offset(20);
        make.left.equalTo(_scr.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
    }];
    [accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editDataBtn.mas_top);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
    }];
    
    UIButton *renzhengBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [renzhengBtn setTitle:@"认证" forState:(UIControlStateNormal)];
    [renzhengBtn addTarget:self action:@selector(renzhengClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_scr addSubview:renzhengBtn];
    [renzhengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_editTF_company.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    //QueryUserInfo *userInfo = [[QueryUserInfo alloc]init];
    
    
}
#pragma mark -- 修改用户头像
-(void)alterHeadClick
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
    [alter_HeadPic setBackgroundImage:image forState:(UIControlStateNormal)];
    [self saveImage:image WithName:@"HeadPic"];
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
#pragma mark 表示图代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        ApproveVC *approveVC = [[ApproveVC alloc]init];
        [self.navigationController pushViewController:approveVC animated:YES];
    }
}
/*
编辑资料->点击编辑资料时，输入框出现
账号管理->进入下一界面
*/
-(void)buttonClick:(QYFileButton*)button
{
    if (button.tag == 1) {
        _editTF_nick.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.view addGestureRecognizer:tapGestureRecognizer];
        
    }
    else if (button.tag == 2){

        NSString *userId = [[NSUserDefaults standardUserDefaults]valueForKey:UserId];
        QYUser *user = [[QYUser alloc]init];
        user.userId = userId;
        user.username = _editTF_nick.text;
        user.sex = _editTF_sex.text;
        
        user.age = _editTF_age.text;
        
        user.address = _editTF_address.text;
        user.email = _editTF_email.text;
        user.business = _editTF_industry.text;
        user.companyName = _editTF_company.text;
        user.link = _editTF_link.text;
        user.info = _editTF_info.text;
        [QYHttpRequest requestModifyUserInfo:user WithBlock:^(NSArray *dataArray) {
            
        }];
    }
}
-(void)accountBtnClick
{
    accountVC = [[AccountVC alloc]init];
    [self.navigationController pushViewController:accountVC animated:YES];
}
/*
改变头像后，进行头像在本地的存储
*/
-(void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    NSData* imageData;
    
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(tempImage)) {
        //返回为png图像。
        imageData = UIImagePNGRepresentation(tempImage);
    }else {
        //返回为JPEG图像。
        imageData = UIImageJPEGRepresentation(tempImage, 1.0);
    }
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPathToFile atomically:NO];
    
}
#pragma mark -- textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _scr.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _scr.contentSize = CGSizeMake(WIDTH, HEIGHT+216);
    _scr.scrollEnabled = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _scr.frame = CGRectMake(0, 0, WIDTH,HEIGHT);
    _scr.contentSize = CGSizeMake(WIDTH, HEIGHT);
    _scr.scrollEnabled = NO;
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    return NO;
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    return YES;
//}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_editTF_nick resignFirstResponder];
    [_editTF_sex resignFirstResponder];
    [_editTF_age resignFirstResponder];
    [_editTF_address resignFirstResponder];
    [_editTF_email resignFirstResponder];
    [_editTF_company resignFirstResponder];
    [_editTF_industry resignFirstResponder];
    [_editTF_info resignFirstResponder];
    [_editTF_link resignFirstResponder];
}
-(void)renzhengClick
{
    ApproveVC *approveVC = [[ApproveVC alloc]init];
    [self.navigationController pushViewController:approveVC animated:YES];
}
-(void)btnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
