//
//  ViewController.m
//  HQSliderView
//
//  Created by 王红庆 on 2016/11/14.
//  Copyright © 2016年 王红庆. All rights reserved.
//

#import "ViewController.h"
#import "HQSliderView.h"
#import "HQTableViewCell.h"

#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define NAV_HEIGHT        64.0
#define SLIDER_HEIGHT     44.0

@interface ViewController ()<UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger menuTag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTopSliderView];
    [self setupTableView];
}

#pragma mark - 创建上部SliderView
- (void)setupTopSliderView
{
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SLIDER_HEIGHT)];
    sliderView.titleArr = @[@"全部", @"待付款", @"已付款", @"退款"];
    sliderView.delegate = self;
    [self.view addSubview:sliderView];
}

#pragma mark - 创建TableView
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT + SLIDER_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT)];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.menuTag == 0) {
        return 3;
    } else if (self.menuTag == 1) {
        return 6;
    } else if (self.menuTag == 2) {
        return 9;
    } else {
        return 12;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQTableViewCell *cell = [HQTableViewCell tableViewCellWithTableView:tableView];
    
    if (self.menuTag == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
    } else if (self.menuTag == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    } else if (self.menuTag == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"已付款 --- 第%ld行", indexPath.row];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"退款 --- 第%ld行", indexPath.row];
    }
    
    return cell;
}

#pragma mark - HQSliderViewDelegate
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button
{
    self.menuTag = button.tag;
    [self.tableView reloadData];
}

@end
