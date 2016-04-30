//
//  AdvertisingVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/11.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AdvertisingVC.h"
#import "Tool_h.h"
#import "Masonry.h"
#import "AdvDetailsVC.h"
#import "CustomButton.h"
#import "PayAdvVC.h"
@interface AdvertisingVC ()
{
    UIView *_backView;
    UIImageView *TopIV;
    UIView *btnBackView;
    BOOL   isHide;
}
@end

@implementation AdvertisingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backView];
    
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backView addSubview:TopIV];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"我的广告";
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    UIButton *MerOrderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [MerOrderBtn setTitle:@"分类" forState:(UIControlStateNormal)];
    [MerOrderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [MerOrderBtn addTarget:self action:@selector(MerOrderClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:MerOrderBtn];
    
    UITableView *MerTV = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR, WIDTH, HEIGHT-TOP_BAR) style:(UITableViewStylePlain)];
    MerTV.delegate = self;
    MerTV.dataSource = self;
    MerTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backView addSubview:MerTV];
    
    [MerTV registerNib:[UINib nibWithNibName:@"MerchantAdvTVCell" bundle:nil] forCellReuseIdentifier:@"MerchantAdvCell"];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top);
        make.centerX.equalTo(_backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-HEIGHT/48);
        make.centerX.equalTo(TopIV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, HEIGHT/24));
    }];
    [MerOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom);
        make.right.equalTo(TopIV.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    btnBackView = [[UIView alloc]init];
    btnBackView.backgroundColor = [UIColor whiteColor];
    btnBackView.hidden = YES;
    isHide = NO;
    [self.view addSubview:btnBackView];
    
}
#pragma mark -表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantAdvCell"];
    return cell;
    
}
#pragma mark -表的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvDetailsVC *advDetails = [AdvDetailsVC new];
    [self.navigationController pushViewController:advDetails animated:YES];
}
-(void)ReturnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//商家订单
-(void)MerOrderClick
{
    if (isHide == NO) {
        btnBackView.hidden = NO;
        [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(TopIV.mas_bottom);
            make.right.equalTo(_backView.mas_right);
            make.size.mas_equalTo(CGSizeMake(WIDTH/4, 80));
        }];

        NSArray *titleArr = @[@"已接单",@"已发单",];
        for (int i = 0; i < 2; i++)  {
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.frame = CGRectMake(0,40*i+1,  WIDTH/4, 40);
            [btn setTitle:[titleArr objectAtIndex:i] forState:(UIControlStateNormal)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = i + 1;
            [btnBackView addSubview:btn];
            
                    UIImageView *bottom_lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39, WIDTH/4, 1)];
                    bottom_lineIV.image = [UIImage imageNamed:@"bottom_line"];
                    [btn addSubview:bottom_lineIV];
            isHide = YES;
        }

    }
    else{
        btnBackView.hidden = YES;
        isHide = NO;
    }
    
}
-(void)BtnClick:(UIButton*)button
{
    switch (button.tag) {
        case 1:
            NSLog(@"已接单");
            break;
        case 2:
            NSLog(@"已发单");
            break;
        default:
            break;
    }
}
@end
