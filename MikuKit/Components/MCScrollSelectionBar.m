//
//  MCScrollSelectionBar.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/9/17.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCScrollSelectionBar.h"

@interface MCScrollSelectionBar () <UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

// 测试滚动选择栏
@property (nonatomic, strong) NSArray<NSString *> *titleArr;
@property (nonatomic, assign) CGFloat unitWidth;
@property (nonatomic, strong) UIScrollView *bgSV;
@property (nonatomic, strong) UIStackView *stackV;
@property (nonatomic, strong) UICollectionView *workmodeCL;

@end

@implementation MCScrollSelectionBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        _unitWidth = 120.0f;
        _titleArr = [NSArray arrayWithArray:titles];
        [self initWorkmodeBar];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    self.workmodeCL.frame = CGRectMake(0, 0, size.width, size.height);
}


#pragma mark - 测试滚动选择栏

- (void)initWorkmodeBar {
    
//    _titleArr = @[@"NormalPhoto", @"TimerPhoto", @"Burst", @"NormalVideo", @"LoopVideo", @"VideoLapse", @"SlowRec"];
    
//    // MARK: UIScrollView + UIStackView 实现
//    _bgSV = [[UIScrollView alloc] initWithFrame:CGRectZero];
//    _bgSV.delegate = self;
//    _bgSV.bounces = NO;
//    _bgSV.decelerationRate = UIScrollViewDecelerationRateNormal;
//    [self.view addSubview:_bgSV];
//    [_bgSV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.centerY.equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
////    _bgSV.contentSize = CGSizeMake(MCBounds.screenW + (_titleArr.count - 1) * self.unitWidth, 50);
//
//    _stackV = [[UIStackView alloc] init];
//    _stackV.distribution = UIStackViewDistributionFillEqually;
//    _stackV.alignment = UIStackViewAlignmentCenter;
//    [_titleArr enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger titleIndex, BOOL * _Nonnull stop) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.tag = 1000 + titleIndex;
//        [btn setTitle:title forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setTitleColor:COLOR_AP_THEME forState:UIControlStateSelected];
//        [btn addTarget:self action:@selector(changeWorkmode:) forControlEvents:UIControlEventTouchUpInside];
//        [_stackV addArrangedSubview:btn];
//        [btn mk_debugBorderWithColor:[UIColor blueColor] width:0.25f];
//    }];
//    [self.bgSV addSubview:_stackV];
//    [_stackV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.left.right.equalTo(self.bgSV);
//        make.left.equalTo(self.bgSV).offset(MCBounds.screenW * 0.5 - self.unitWidth * 0.5);
//        make.right.equalTo(self.bgSV).offset(- (MCBounds.screenW * 0.5 - self.unitWidth * 0.5));
//        make.height.mas_equalTo(50);
//        make.width.mas_equalTo(self.unitWidth * self.titleArr.count);
//    }];
//    [_stackV mk_debugBorderWithColor:[UIColor redColor] width:0.5f];
//
//    UIButton *btn = (UIButton *)self.stackV.arrangedSubviews.firstObject;
//    btn.selected = YES;
//    self.bgSV.contentInset = UIEdgeInsetsMake(0, MCBounds.screenW * 0.5 - self.unitWidth * 0.5, 0, MCBounds.screenW * 0.5 - self.unitWidth * 0.5);
    
    // MARK: UICollection 实现
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    _workmodeCL = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _workmodeCL.dataSource = self;
    _workmodeCL.delegate = self;
    [_workmodeCL registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    _workmodeCL.bounces = NO;
//    _workmodeCL.contentSize = CGSizeMake((_titleArr.count - 1) * 100 + MCBounds.screenW, 50);
    _workmodeCL.contentInset = UIEdgeInsetsMake(0, MCBounds.screenW * 0.5 - self.unitWidth * 0.5, 0, MCBounds.screenW * 0.5 - self.unitWidth * 0.5);
    [self addSubview:_workmodeCL];
//    [_workmodeCL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(self);
//    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.unitWidth, self.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat actualX = scrollView.contentOffset.x;
    CGFloat logicalX = scrollView.contentOffset.x + (MCBounds.screenW * 0.5 - self.unitWidth * 0.5);
    NSUInteger selectIndex = 0;
    if (logicalX < 60) {
        selectIndex = 0;
    } else {
        selectIndex = (NSUInteger)ceilf((logicalX - self.unitWidth * 0.5) / self.unitWidth);
    }
    
    NSLog(@"真实偏移量 = %.f 逻辑偏移量 = %.f 选中下标 = %zd, 逻辑偏移余数 = %zd", actualX, logicalX, selectIndex, (NSInteger)ceilf(logicalX) % (NSInteger)self.unitWidth);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat actualX = scrollView.contentOffset.x;
    CGFloat logicalX = scrollView.contentOffset.x + (MCBounds.screenW * 0.5 - self.unitWidth * 0.5);
    // 计算选中下标
    NSUInteger selectIndex = 0;
    if (logicalX < 60) {
        selectIndex = 0;
    } else {
        selectIndex = (NSUInteger)ceilf((logicalX - self.unitWidth * 0.5) / self.unitWidth);
    }
    
    // 计算item居中后的真实偏移量
    CGFloat lastX = - (MCBounds.screenW * 0.5 - self.unitWidth * 0.5) + self.unitWidth * selectIndex;
    
    // UICollectionView 实现
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.workmodeCL scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        UICollectionViewCell *cell = [self collectionView:self.workmodeCL cellForItemAtIndexPath:indexPath];
        if ([cell.contentView.subviews.firstObject isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)cell.contentView.subviews.firstObject;
            [MCTipsUtils showTips:btn.currentTitle];
        }
    });
    
    
//    // UIScrollView + UIStackView 实现
//    [self.stackV.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)obj;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (idx == selectIndex) {
//                    btn.selected = YES;
//                    [scrollView setContentOffset:CGPointMake(lastX, 0) animated:YES];
//                } else {
//                    btn.selected = NO;
//                }
//            });
//        }
//    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    if (cell.contentView.subviews.count == 0) {
        UIButton *btn = [[UIButton alloc] init];
        [cell.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(cell);
        }];
        [btn mk_borderWithColor:[UIColor whiteColor] width:0.25f];
    }
    if ([cell.contentView.subviews.firstObject isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)cell.contentView.subviews.firstObject;
        [btn setTitle:self.titleArr[indexPath.row] forState:UIControlStateNormal];
    }

    return cell;
}

- (void)changeWorkmode:(UIButton *)sender {
    [MCTipsUtils showTips:self.titleArr[sender.tag - 1000]];
}

@end
