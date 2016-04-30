//
//  AdvDetailsVC.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/25.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "AdvDetailsVC.h"
#import "Masonry.h"
#import "Tool_h.h"
#import "CustomBtn.h"
#import "AdvDetailsCell.h"
#import "CustomButton.h"
#import "AdvDetailsCell.h"
@interface AdvDetailsVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_scr;
    UIImageView *TopIV;
    UIView *view;
    UIView *footView;//区尾视图
}
@end

@implementation AdvDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [self.view addSubview:TopIV];
    
    UILabel *TitleLabel = [[UILabel alloc]init];
    TitleLabel.text = @"广告详情";
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    TitleLabel.textColor = [UIColor whiteColor];
    [TopIV addSubview:TitleLabel];
    
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];


    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
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

    
    UITableView *advDetailsTV = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR, WIDTH, HEIGHT-TOP_BAR) style:(UITableViewStylePlain)];
    advDetailsTV.delegate = self;
    advDetailsTV.dataSource = self;
    [self.view addSubview:advDetailsTV];
    [advDetailsTV registerNib:[UINib nibWithNibName:@"AdvDetailsCell" bundle:nil] forCellReuseIdentifier:@"advDetailsCell"];
    
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//广告详情
-(void)CheckCommentClick
{
    
}
//公司信息
-(void)MerNewsClick
{
    
}
//跳转到商家网页
-(void)JumpMerWebClick
{
    
}
#pragma mark -表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
    if (indexPath.section == 1) {
        return 0;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 120;
    }
    else{
        return 45;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 0;
    }
    else if (section == 2){
        return 3;
    }
    return 3;
    
}
#pragma mark --自定义区头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *bottom_line_1 = [[UIImageView alloc]init];
    bottom_line_1.image = [UIImage imageNamed:@"bottom_line"];
    [headView addSubview:bottom_line_1];
    [bottom_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView.mas_bottom);
        make.centerX.equalTo(headView.mas_centerX);
        make.height.mas_equalTo(5);
    }];
    if (section == 0) {
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"标题:";
        [headView addSubview:titleLabel];
        
        UILabel *title_NameLabel = [[UILabel alloc]init];
        title_NameLabel.text = @"SONY微单优惠大酬宾！！！";
        [headView addSubview:title_NameLabel];
        
        UILabel *endTimeLabel = [[UILabel alloc]init];
        endTimeLabel.text = @"截止日期：";
        endTimeLabel.font = FONT(12);
        [headView addSubview:endTimeLabel];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2016.7.12";
        timeLabel.font = FONT(12);
        [headView addSubview:timeLabel];
        
        UILabel *regionLabel = [[UILabel alloc]init];
        regionLabel.font = FONT(12);
        regionLabel.text = @"地区：";
        [headView addSubview:regionLabel];
        
        UILabel *region_DetailsLabel = [[UILabel alloc]init];
        region_DetailsLabel.text = @"湖南省长沙市芙蓉区";
        region_DetailsLabel.font = FONT(12);
        [headView addSubview:region_DetailsLabel];
        
        UILabel *quotaLabel = [[UILabel alloc]init];
        quotaLabel.text = @"任务量：";
        quotaLabel.font = FONT(12);
        [headView addSubview:quotaLabel];
        
        UILabel *quota_count_Label = [[UILabel alloc]init];
        quota_count_Label.text = @"600";
        quota_count_Label.font = FONT(12);
        [headView addSubview:quota_count_Label];
        
        UILabel *univalenceLabel = [[UILabel alloc]init];
        univalenceLabel.text = @"单价：";
        [headView addSubview:univalenceLabel];
        
        UILabel *univalence_RMB_Label = [[UILabel alloc]init];
        univalence_RMB_Label.text = @"0.18";
        [headView addSubview:univalence_RMB_Label];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView.mas_top).with.offset(5);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.height.mas_equalTo(30);
        }];
        [title_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_top);
            make.left.equalTo(titleLabel.mas_right);
            make.height.mas_equalTo(30);
        }];
        [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).with.offset(5);
            make.left.equalTo(titleLabel.mas_left);
            make.height.mas_equalTo(15);
        }];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(endTimeLabel.mas_top);
            make.left.equalTo(endTimeLabel.mas_right);
            make.height.mas_equalTo(15);
        }];
        [regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(endTimeLabel.mas_top);
            make.left.equalTo(timeLabel.mas_right).with.offset(15);
            make.height.mas_equalTo(15);
        }];
        [region_DetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(endTimeLabel.mas_top);
            make.left.equalTo(regionLabel.mas_right);
            make.height.mas_equalTo(15);
        }];
        [quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(endTimeLabel.mas_bottom).with.offset(5);
            make.left.equalTo(endTimeLabel.mas_left);
            make.height.mas_equalTo(20);
        }];
        [quota_count_Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(quotaLabel.mas_top);
            make.left.equalTo(quotaLabel.mas_right);
            make.height.mas_equalTo(20);
        }];
        [univalenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(quotaLabel.mas_bottom).with.offset(5);
            make.left.equalTo(quotaLabel.mas_left);
            make.height.mas_equalTo(30);
        }];
        [univalence_RMB_Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(univalenceLabel.mas_top);
            make.left.equalTo(univalenceLabel.mas_right);
            make.height.mas_equalTo(30);
        }];
        return headView;
    }
    else if (section == 1){
        UILabel *goods_linkLabel = [[UILabel alloc]init];
        goods_linkLabel.text = @"商品订单链接";
        [headView addSubview:goods_linkLabel];
        
        UILabel *wechatLabel = [[UILabel alloc]init];
        wechatLabel.text = @"微信号:";
        wechatLabel.font = FONT(12);
        [headView addSubview:wechatLabel];
        
        UILabel *wechat_numberLabel = [[UILabel alloc]init];
        wechat_numberLabel.text = @"hhhh123123";
        wechat_numberLabel.font = FONT(12);
        [headView addSubview:wechat_numberLabel];
        
        UILabel *taobao_LinkLabel = [[UILabel alloc]init];
        taobao_LinkLabel.text = @"淘宝链接：";
        taobao_LinkLabel.font = FONT(12);;
        [headView addSubview:taobao_LinkLabel];
        
        UILabel *Meituan_linkLabel = [[UILabel alloc]init];
        Meituan_linkLabel.text = @"美团链接:";
        Meituan_linkLabel.font = FONT(12);
        [headView addSubview:Meituan_linkLabel];
        
        [goods_linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView.mas_top).with.offset(5);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
        }];
        [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goods_linkLabel.mas_bottom).with.offset(5);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.height.mas_equalTo(20);
        }];
        [wechat_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wechatLabel.mas_top);
            make.left.equalTo(wechatLabel.mas_right);
            make.height.mas_equalTo(20);
        }];
        [taobao_LinkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wechatLabel.mas_bottom).with.offset(5);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.height.mas_equalTo(20);
        }];
        [Meituan_linkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(taobao_LinkLabel.mas_bottom).with.offset(5);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.height.mas_equalTo(20);
        }];
    }
    else if (section == 2){
        UILabel *commentsLabel = [[UILabel alloc]init];
        commentsLabel.text = @"订单评论：";
        [headView addSubview:commentsLabel];
        [commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView.mas_top).with.offset(10);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(WIDTH/3, 20));
        }];
    }
    else if (section == 3){
        UILabel *orderRecordLabel = [[UILabel alloc]init];
        orderRecordLabel.text = @"谁接了此单：";
        [headView addSubview:orderRecordLabel];
        [orderRecordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headView.mas_top).with.offset(10);
            make.left.equalTo(headView.mas_left).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(WIDTH/3, 20));
        }];
    }

    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2 ) {
        return 50;
    }
    else if (section == 3){
        return 50;
    }
        return 0;
}
#pragma mark -- 自定义区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];

    if (section == 2) {
        footView.backgroundColor = [UIColor whiteColor];
        UIImageView *bottom_line_1 = [[UIImageView alloc]init];
        bottom_line_1.image = [UIImage imageNamed:@"bottom_line"];
        [footView addSubview:bottom_line_1];
        [bottom_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(footView.mas_bottom);
            make.centerX.equalTo(footView.mas_centerX);
            make.height.mas_equalTo(5);
        }];
        UIButton *checkBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [checkBtn setTitle:@"查看更多" forState:(UIControlStateNormal)];
        [checkBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [checkBtn addTarget:self action:@selector(CheckMoreClick) forControlEvents:(UIControlEventTouchUpInside)];
        [footView addSubview:checkBtn];
        [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footView.mas_centerY);
            make.centerX.equalTo(footView.mas_centerX);
            make.height.mas_equalTo(20);
        }];
        return footView;
    }
    else if (section == 3){
        footView.backgroundColor = BackGroundColor(240, 240, 240, 1);
        UIButton *SpotBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        SpotBtn.layer.masksToBounds = YES;
        SpotBtn.layer.cornerRadius = 4;
        SpotBtn.layer.borderWidth = 1;
        SpotBtn.layer.borderColor = [UIColor redColor].CGColor;
        [SpotBtn setTitle:@"点赞" forState:(UIControlStateNormal)];
        [SpotBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        SpotBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [SpotBtn addTarget:self action:@selector(LeafletsClick:) forControlEvents:(UIControlEventTouchUpInside)];
        SpotBtn.tag = 1;
        [footView addSubview:SpotBtn];
        
        UIButton *OrderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [OrderBtn setBackgroundImage:[UIImage imageNamed:@"banner"] forState:(UIControlStateNormal)];
        OrderBtn.layer.masksToBounds = YES;
        OrderBtn.layer.cornerRadius = 4;
        OrderBtn.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [OrderBtn setTitle:@"接  单" forState:(UIControlStateNormal)];
        [OrderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        OrderBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [OrderBtn addTarget:self action:@selector(LeafletsClick:) forControlEvents:(UIControlEventTouchUpInside)];
        OrderBtn.tag = 2;
        [footView addSubview:OrderBtn];
        
        [SpotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footView.mas_centerY);
            make.left.equalTo(footView.mas_left).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
        }];
        [OrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(WIDTH/5*2, 40));
            make.right.equalTo(footView.mas_right).with.offset(-20);
        }];
        return footView;
    }
    return footView;
}
#pragma mark --评论的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"advDetailsCell"];
        return cell;
    
}
#pragma mark --区头随单元格滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 120;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

//查看更多评论
-(void)CheckMoreClick
{
    
}
#pragma mark --spotAndOrder
-(void)LeafletsClick:(UIButton*)button
{
    switch (button.tag) {
        case 1:
            NSLog(@"点赞");
            break;
        case 2:
            NSLog(@"接单");
            break;
        default:
            break;
    }
}
@end
