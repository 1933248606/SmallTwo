//
//  AccountVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/11.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AccountVC.h"
#import "CustomButton.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "AcountTVCell.h"
#import "AmendPswVC.h"
@interface AccountVC ()
{
    UIView         *_backView;
    NSArray        *NameArr;
    NSArray        *AccountArr;
    NSArray        *AccountIconArr;
    AmendPswVC     *amendVC;
}
@end

@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    _backView = [UIView new];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    UIButton *returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [returnBtn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:returnBtn];
    
    UIImageView *topIV = [UIImageView new];
    topIV.image = [UIImage imageNamed:@"banner"];
    topIV.frame = CGRectMake(0, 0, WIDTH, TOP_BAR);
    [_backView addSubview:topIV];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"账号管理";
    titleLabel.textColor = [UIColor whiteColor];
    [topIV addSubview:titleLabel];
    
    UITableView *AccountTV = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR, WIDTH, 210) style:(UITableViewStylePlain)];
    AccountTV.delegate = self;
    AccountTV.dataSource = self;
    AccountTV.bounces = NO;
    AccountTV.separatorColor = [UIColor grayColor];
    [AccountTV registerNib:[UINib nibWithNibName:@"AcountTVCell" bundle:nil] forCellReuseIdentifier:@"accountCell"];
    [_backView addSubview:AccountTV];
    
    [AccountTV registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountCell"];
    AccountArr = @[@"身份证号：",@"手机号:",];
    AccountIconArr = [[NSMutableArray alloc]initWithObjects:@"my_Idcard",@"my_phone",nil];
    UIButton *CancelAccountBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [CancelAccountBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
    [CancelAccountBtn setTitle:@"注销帐号" forState:(UIControlStateNormal)];
    CancelAccountBtn.layer.masksToBounds = YES;
    CancelAccountBtn.layer.cornerRadius = 4;
    CancelAccountBtn.titleLabel.font = [UIFont systemFontOfSize:24];
    [CancelAccountBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [CancelAccountBtn addTarget:self action:@selector(CancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:CancelAccountBtn];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topIV.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topIV.mas_centerX);
        make.bottom.equalTo(topIV.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 20));
    }];
    [CancelAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AccountTV.mas_bottom).with.offset(10);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH-WIDTH/16, HEIGHT/13));
    }];
    
}
#pragma mark -表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 50;
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
        return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AcountTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountCell"];
    cell.accountNameLabel.text = [AccountArr objectAtIndex:indexPath.row];
    cell.accountPic.image = [UIImage imageNamed:[AccountIconArr objectAtIndex:indexPath.row]];
    cell.accountLabel.text = @"未绑定账号";
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
        label.text = @"当前账号";
        [headerView addSubview:label];
        UILabel *accountLabel = [[UILabel alloc]init];
        accountLabel.text = @"12345678911";
        [headerView addSubview:accountLabel];
        [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView.mas_centerY);
            make.right.equalTo(headerView.mas_right).with.offset(-10);
            make.height.mas_equalTo(40);
        }];
        UIImageView *bottom_lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, WIDTH, 1)];
        bottom_lineIV.image = [UIImage imageNamed:@"bottom_line.png"];
        [headerView addSubview:bottom_lineIV];
    }
    else if (section == 1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
        label.text = @"账号绑定";
        [headerView addSubview:label];
        UIImageView *bottom_lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, WIDTH, 1)];
        bottom_lineIV.image = [UIImage imageNamed:@"bottom_line.png"];
        [headerView addSubview:bottom_lineIV];
    }
    else if (section == 2) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(0, 0, WIDTH, 40);
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(HeadButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [headerView addSubview:btn];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 50)];
        label.text = @"密码修改";
        [btn addSubview:label];
        UIImageView *bottom_lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
        bottom_lineIV.image = [UIImage imageNamed:@"bottom_line.png"];
        [headerView addSubview:bottom_lineIV];
    }
    return headerView;

}
#pragma mark 表示图代理方法//??????
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击单元格,进入已编辑好的界面
//    secondViewController*con = [[secondViewController alloc]init];
//    con.nstr = Array [indexPath.row];
//    [self.navigationController pushViewController:con animated:YES];
}

-(void)CancelBtnClick
{
    
}
-(void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)HeadButton:(UIButton*)Btn
{
    amendVC = [AmendPswVC new];
            [self.navigationController pushViewController:amendVC animated:YES];
}
@end
