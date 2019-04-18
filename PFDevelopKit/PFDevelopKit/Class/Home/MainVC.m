//
//  MainVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/8.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "MainVC.h"

@interface MainVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *moduleListTB;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSource;

@end

@implementation MainVC

#pragma mark - 控制器生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initSubviews];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}


#pragma mark - 初始化

- (void)initData {
    self.dataSource = @[@{@"sectionTitle":@"UI控件",
                          @"classArr":@[@{@"className":@"PFWKWebView",
                                          @"title":@"使用WKWebView"},
                                        @{@"className":@"PFTestAlertVC",
                                          @"title":@"使用UIAlertController"},
                                        @{@"className":@"PFFilter",
                                          @"title":@"封装电商筛选器"},
                                        @{@"className":@"PFCLViewDemoVC",
                                          @"title":@"使用UICollectionView"}]},
                        @{@"sectionTitle":@"CoreMotion",
                          @"classArr":@[@{@"className":@"PFMotionVC",
                                          @"title":@"传感器使用"},
                                        @{@"className":@"WalkRoutePlanVC",
                                          @"title":@"步行路线规划"},
                                        @{@"className":@"RideRoutePlanVC",
                                          @"title":@"骑行路线规划"}]}
                        ];
}


- (void)initSubviews {
    self.title = @"PFDevelopKit";
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 修改子控制器导航栏返回按钮的文字（需要在父控制器中修改）
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // 添加展示功能模块（控制器）的TB
    _moduleListTB = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.moduleListTB.dataSource = self;
    self.moduleListTB.delegate = self;
    self.moduleListTB.autoresizingMask = UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.moduleListTB];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource[section] valueForKey:@"classArr"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellRid = @"ModuleTBCellRid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellRid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.textLabel.text = self.dataSource[indexPath.section][@"classArr"][indexPath.row][@"title"];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *targetVC = [[NSClassFromString(self.dataSource[indexPath.section][@"classArr"][indexPath.row][@"className"]) alloc] init];
    targetVC.title = self.dataSource[indexPath.section][@"classArr"][indexPath.row][@"title"];
    [self.navigationController pushViewController:targetVC animated:YES];
}

@end
