//
//  OrderViewController.m
//  Demo1
//
//  Created by 不忘初心方得始终 on 16/3/10.
//  Copyright © 2016年 不忘初心方得始终. All rights reserved.
//

#import "OrderViewController.h"
#import "Masonry.h"
#import "CustomButton.h"
#import "Tool_h.h"
#import "OrderTableViewCell.h"
#import "AdvDetailsVC.h"
@interface OrderViewController ()
{
    UIView          *_backview;          //用于做屏幕适配的视图
    UIImageView     *TopIV;              //顶栏视图
    BOOL            isHide;
    UIView          *btnBackView;
}
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *searchResult;
@end

@implementation OrderViewController
-(void)dealloc
{
    /*释放掉上拉刷新的控件*/
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _backview = [[UIView alloc]init];
    _backview.backgroundColor = BackGroundColor(240, 240, 240, 1);
    [self.view addSubview:_backview];
    TopIV = [[UIImageView alloc]init];
    TopIV.image = [UIImage imageNamed:@"banner"];
    TopIV.userInteractionEnabled = YES;
    [_backview addSubview:TopIV];
    UIButton *ReturnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [ReturnBtn setImage:[UIImage imageNamed:@"my_back"] forState:(UIControlStateNormal)];
    [ReturnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 0)];
    [ReturnBtn addTarget:self action:@selector(ReturnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:ReturnBtn];
    
    UIButton *rankBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rankBtn setTitle:@"排序" forState:(UIControlStateNormal)];
    [rankBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 0, 5, 5))];
    [rankBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [rankBtn addTarget:self action:@selector(rankClick) forControlEvents:(UIControlEventTouchUpInside)];
    [TopIV addSubview:rankBtn];
    
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));
    }];
    [TopIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backview.mas_top);
        make.centerX.equalTo(_backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, TOP_BAR));
    }];
    [ReturnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TopIV.mas_left);
        make.bottom.equalTo(TopIV.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH/10, WIDTH/10));
    }];
    [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.right.equalTo(TopIV.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    self.personTV = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR, WIDTH, HEIGHT-TOP_BAR) style:(UITableViewStylePlain)];
    _personTV.delegate = self;
    _personTV.dataSource = self;
    _personTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_backview addSubview:_personTV];
    
    [_personTV registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderCell"];
    self.searchBar = [[UISearchBar alloc]init];
    _searchBar.keyboardType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"请输入搜索关键字";
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.barStyle = UIBarStyleDefault;
    [TopIV addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(TopIV.mas_bottom).with.offset(-10);
        make.centerX.equalTo(TopIV.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(WIDTH/5*3, 30));
    }];
    UIImage *img = [[UIImage imageNamed:@"banner"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [_searchBar setBackgroundImage:img];
    btnBackView = [[UIView alloc]init];
    btnBackView.backgroundColor = [UIColor whiteColor];
    btnBackView.hidden = YES;
    isHide = NO;
    [self.view addSubview:btnBackView];
    
//    __weak OrderViewController *weakSelf = self;
//    self.personTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//    }];
    self.personTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.personTV.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullTheloadData)];
    [self.personTV.mj_header beginRefreshing];
}
-(void)loadData
{
    NSLog(@"下拉加载");
    [self.personTV.mj_header endRefreshing];
}
-(void)pullTheloadData
{
    NSLog(@"上拉刷新");
    [self.personTV.mj_footer endRefreshing];
}
-(void)ReturnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rankClick
{
    if (isHide == NO) {
        btnBackView.hidden = NO;
        [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(TopIV.mas_bottom);
            make.right.equalTo(_backview.mas_right);
            make.size.mas_equalTo(CGSizeMake(WIDTH/4, 80));
        }];
        
        NSArray *titleArr = @[@"单价最高",@"任务量最大",];
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
-(void)BtnClick:(UIButton*)btn
{
    
}
- (void)initTableView{
//    self.searchResult = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-64-CGRectGetHeight(self.searchBar.frame))];
//    _searchResult.dataSource = self;
//    _searchResult.delegate =self;
//    _searchResult.tableFooterView = [[UIView alloc]init];
//    [_searchResult registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.view addSubview:self.searchResult];
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    [self initTableView];
    NSLog(@"heahtdyfgh");
    
    //改变取消的文本
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"取消吗");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
#pragma mark -表的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdvDetailsVC *advDetailsVC = [[AdvDetailsVC alloc]init];
    [self.navigationController pushViewController:advDetailsVC animated:YES];
}


@end
