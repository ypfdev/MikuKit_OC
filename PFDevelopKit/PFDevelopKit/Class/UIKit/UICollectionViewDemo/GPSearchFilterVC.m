//
//  GPSearchFilterVC.m
//  PFDevelopKit
//
//  Created by 原鹏飞 on 2018/11/27.
//  Copyright © 2018 YuanPengFei. All rights reserved.
//

#import "GPSearchFilterVC.h"
#import "GPSearchFilterCLHeader.h"
#import "GPSearchFilterCLCell.h"

static NSString * const GPSearchFilterCLCellRid = @"GPSearchFilterCLCell";
static NSString * const GPSearchFilterCLHeaderRid = @"GPSearchFilterCLHeader";

@interface GPSearchFilterVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) UIView *maskBG;
@property (nonatomic, strong) UIView *filterBG;
@property (nonatomic, strong) UICollectionView *filterCL;

@end

@implementation GPSearchFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initSubviews];
}


- (void)initData {
    _dataDict = @{@"priceArr":@[@{@"price":@"100-299", @"priceId":@"001"},
                               @{@"price":@"300-499", @"priceId":@"002"},
                               @{@"price":@"500-999", @"priceId":@"003"}
                               ],
                 @"propertyArr":@[@{@"sectionTitle":@"类别",
                                    @"sectionId":@"100",
                                    @"itemArr":@[@{@"itemTitle":@"烤箱", @"itemId":@"101"},
                                                 @{@"itemTitle":@"蒸箱", @"itemId":@"102"},
                                                 @{@"itemTitle":@"蒸烤箱", @"itemId":@"103"},
                                                 @{@"itemTitle":@"微波炉", @"itemId":@"104"},
                                                 @{@"itemTitle":@"光波炉", @"itemId":@"105"}
                                                 ]
                                    },
                                  @{@"sectionTitle":@"容量",
                                    @"sectionId":@"200",
                                    @"itemArr":@[@{@"itemTitle":@"15L以下", @"itemId":@"201"},
                                                 @{@"itemTitle":@"16-25L", @"itemId":@"202"},
                                                 @{@"itemTitle":@"26-35L", @"itemId":@"203"},
                                                 @{@"itemTitle":@"36-45L", @"itemId":@"204"},
                                                 @{@"itemTitle":@"46-60L", @"itemId":@"205"},
                                                 @{@"itemTitle":@"60L以上", @"itemId":@"206"}
                                                 ]
                                    },
                                  @{@"sectionTitle":@"功能特点",
                                    @"sectionId":@"300",
                                    @"itemArr":@[@{@"itemTitle":@"特点1", @"itemId":@"301"},
                                                 @{@"itemTitle":@"特点2", @"itemId":@"302"},
                                                 @{@"itemTitle":@"特点3", @"itemId":@"303"},
                                                 @{@"itemTitle":@"特点4", @"itemId":@"304"},
                                                 @{@"itemTitle":@"特点5", @"itemId":@"305"},
                                                 @{@"itemTitle":@"特点6", @"itemId":@"306"},
                                                 @{@"itemTitle":@"特点7", @"itemId":@"307"},
                                                 @{@"itemTitle":@"特点8", @"itemId":@"308"}
                                                 ]
                                    },
                                  ]
                 };
    
}


- (void)initSubviews {
    self.view.backgroundColor = UIColor.clearColor;
    
    _maskBG = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_maskBG];
    _maskBG.backgroundColor = [UIColor mk_colorWithHex:0xF6F6F6 alpha:1.0f];
    [_maskBG addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    
    _filterBG = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width *0.85, self.view.bounds.size.height)];
    [self.view addSubview:_filterBG];
    _filterBG.backgroundColor = UIColor.whiteColor;
    
    [self initFilterCL];
    
}


- (void)initFilterCL {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width *0.85, kAdaptedWidth(40));
    flowLayout.itemSize = CGSizeMake(kAdaptedWidth(100), kAdaptedWidth(40));
    flowLayout.minimumLineSpacing = 2.0f;
    flowLayout.minimumInteritemSpacing = 2.0f;
    flowLayout.sectionInset = UIEdgeInsetsMake(kAdaptedWidth(5), 0, 0, 0);
    
    _filterCL = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kAdaptedWidth(150), self.filterBG.bounds.size.width, self.filterBG.bounds.size.height - kAdaptedWidth(200)) collectionViewLayout:flowLayout];
    [self.filterBG addSubview:_filterCL];
    [_filterCL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filterBG).offset(kAdaptedWidth(150));
        make.left.right.equalTo(self.filterBG);
        make.bottom.equalTo(self.filterBG).offset(kAdaptedWidth(-50));
    }];
    [_filterCL registerClass:[GPSearchFilterCLHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSearchFilterCLHeaderRid];
    [_filterCL registerClass:[GPSearchFilterCLCell class] forCellWithReuseIdentifier:GPSearchFilterCLCellRid];
    _filterCL.dataSource = self;
    _filterCL.delegate = self;
    _filterCL.backgroundColor = UIColor.orangeColor;
    
    
}


- (void)tap:(UITapGestureRecognizer *)tap {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)showAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        
        self.maskBG.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
        self.filterBG.frame = CGRectMake(self.view.bounds.size.width * 0.15, 0, self.view.bounds.size.width *0.85, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GPSearchFilterCLCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GPSearchFilterCLCellRid forIndexPath:indexPath];
    
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    GPSearchFilterCLHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GPSearchFilterCLHeaderRid forIndexPath:indexPath];
    
    
    return header;
}


#pragma mark - UICollectionViewDelegate


@end
