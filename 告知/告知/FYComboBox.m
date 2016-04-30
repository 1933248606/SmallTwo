#import "FYComboBox.h"
//#import "QYHttpRequest.h"
#import "QYUser.h"
#import "Tool_h.h"
#import "Masonry.h"
#import "RegionModel.h"

@interface FYComboBox ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation FYComboBox

static NSString *cellIdentifier = @"FYComboBoxCellIdentifier";
/*
是xib文件就加载xib文件
*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}
/*
创建按钮-》按钮是View的属性，无标题，需要设置按钮的点击事件，来改变tableView不同的数据源
创建tableView
*/
- (void)setup
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    self.button.backgroundColor = [UIColor clearColor];
    [self.button setTitle:@"" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(comboTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.button];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), WIDTH, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.tableView];
    
    [self setDefaultValues];
}

- (void)setDefaultValues
{
    self.maxRows = 5;
    self.cellHeight = 40.f;
    self.cellBackgroundColor = [UIColor whiteColor];
    self.cellTextColor = [UIColor blackColor];
    self.cellTextFont = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier].textLabel.font;
    self.cellLineColor = [UIColor clearColor];
    self.comboBackgroundColor = [UIColor clearColor];
    self.minimumWidth = CGFLOAT_MAX;
    self.showsScrollIndicator = YES;
    self.animationShowDuration = .25;
    self.animationHideDuration = .25;
}

- (CGFloat)heightWithMaxRows:(NSInteger)maxRows
{
    NSInteger rows = [self.delegate comboBoxNumberOfRows:self];
    
    CGFloat total = 0.0f;
    /*
    i小于最大行数且小于cell的个数 
     如果遵循代理，就显示返回的cell的高度
     否则返回默认的高度
    */
    for (int i = 0; i < maxRows && i < rows; i++) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(comboBox:heightForRow:)]) {
            total += [self.delegate comboBox:self heightForRow:i];
        } else {
            total += self.cellHeight;
        }
    }
    
    return total;
}
/*
当按钮闭合时，需要打开时，其中的操作原理
当按钮状态为闭合时，
打开按钮，刷新表
*/
- (void)openAnimated:(BOOL)animated
{
    if (self.state == FYComboBoxStateClosed) {
        [self.tableView reloadData];
        
        if ([self.delegate comboBoxNumberOfRows:self] > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }
    
    CGRect buttonFrame = self.button.frame;
    CGRect tableFrame = CGRectMake(0, CGRectGetHeight(buttonFrame), CGRectGetWidth(self.frame), CGRectGetHeight(self.tableView.frame));
    /*
    view不为空，View是自身 
    */
    UIView *toView = self.comboToView != nil ? self.comboToView : self;
    /*
    如果tableview的父视图不是toView那么将tableView添加到toView上 
    */
    if (self.tableView.superview != toView) {
        [toView addSubview:self.tableView];
    }
    /*
     转换接收者坐标系中的矩形到其他视图
    */
    tableFrame = [self convertRect:tableFrame toView:toView];
    
    self.tableView.frame = tableFrame;
    
    CGFloat height = [self heightWithMaxRows:self.maxRows];
    tableFrame.size.height = height;
    tableFrame.size.width = self.minimumWidth != CGFLOAT_MAX ? MAX(self.minimumWidth, CGRectGetWidth(buttonFrame)) : CGRectGetWidth(buttonFrame);
    
    CGRect newFrame = self.frame;
    
    if (toView == self) {
        newFrame.size.height = CGRectGetHeight(buttonFrame) + height;
    }
    
    void(^openBlock)() = ^{
        self.frame = newFrame;
        self.tableView.frame = tableFrame;
    };
    
    if (animated) {
        [UIView animateWithDuration:self.animationShowDuration animations:openBlock completion:^(BOOL finished) {
        }];
    } else {
        openBlock();
    }
//    [QYHttpRequest requestProvinceInfo:^(NSArray *dataArray) {
//        
//    }];
}
/*
当按钮闭合时，tableView的坐标改变，改变为0，
 整个View的坐标为设置的Button的坐标的位置
 然后再将新的值赋值给View和tableview的坐标
*/
- (void)closeAnimated:(BOOL)animated
{
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = 0;
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CGRectGetHeight(self.button.frame);
    
    void(^closeBlock)() = ^{
        self.frame = newFrame;
        self.tableView.frame = tableFrame;
    };
    
    if (animated) {
        [UIView animateWithDuration:self.animationHideDuration animations:closeBlock completion:^(BOOL finished) {
        }];
    } else {
        closeBlock();
    }
}

#pragma mark - Interface Builder

- (void)prepareForInterfaceBuilder
{
}

#pragma mark - Events
/*
点击事件
按钮两种状态  打开和闭合  
 打开状态下让他闭合，闭合状态下让它打开
*/
- (void)comboTouch:(id)sender
{
    switch (self.state) {
        case FYComboBoxStateOpened: {
            
            [self closeAnimated:YES];
        }
            break;
            
        case FYComboBoxStateClosed: {
            
        [self openAnimated:YES];
        }
            break;
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每个tableView返回的cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = self.comboBackgroundColor;
    tableView.showsVerticalScrollIndicator = self.showsScrollIndicator;
    tableView.rowHeight = self.cellHeight;
    
    return [self.delegate comboBoxNumberOfRows:self];
}
//cell上显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSInteger lineTag = 100;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        
        UIView *lineView = [UIView new];
        lineView.tag = lineTag;
        lineView.backgroundColor = [UIColor clearColor];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [cell.contentView addSubview:lineView];
        
        NSDictionary *views = @{@"line": lineView};
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(1)]-0-|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[line]-0-|" options:0 metrics:nil views:views]];
        
        [cell.contentView setNeedsUpdateConstraints];
    }
    
    UIView *lineView = [cell.contentView viewWithTag:100];
    
    lineView.backgroundColor = self.cellLineColor;
    
    cell.contentView.backgroundColor = self.cellBackgroundColor;
    cell.textLabel.textColor = self.cellTextColor;
    cell.textLabel.font = FONT(14);
    /*
    cell上显示的内容就是数组中返回的标题
    */
    cell.textLabel.text = [self.delegate comboBox:self titleForRow:indexPath.row];
    UIImageView *bottom_line_IV = [[UIImageView alloc]init];
    bottom_line_IV.image = [UIImage imageNamed:@"bottom_line"];
    [cell addSubview:bottom_line_IV];
    [bottom_line_IV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.mas_centerX);
        make.bottom.equalTo(cell.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
    }];
    return cell;
}
/*
 
通过传入不同的index.row的值，获得每个cell相应的城市

*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(comboBox:didSelectRow:)]) {
        [self.delegate comboBox:self didSelectRow:indexPath.row];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.cellHeight;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(comboBox:heightForRow:)]) {
        height = [self.delegate comboBox:self heightForRow:indexPath.row];
    }
    
    return height;
}

#pragma mark - Setters

- (void)setState:(FYComboBoxState)state animated:(BOOL)animated
{
    switch (state) {
        case FYComboBoxStateOpened: {
            [self openAnimated:animated];
        }
            break;
            
        case FYComboBoxStateClosed: {
            [self closeAnimated:animated];
        }
            break;
    }
}

#pragma mark - Getters

- (FYComboBoxState)state
{
    return CGRectGetHeight(self.tableView.frame) == 0.f ? FYComboBoxStateClosed : FYComboBoxStateOpened;
}

@end
