//
//  MCUniversalCLFlowLayout.h
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/24.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCUniversalCLFlowLayoutDelegate

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath page:(int)page;

@end

@interface MCUniversalCLFlowLayout : UICollectionViewFlowLayout

// 一行中 cell的个数
@property (nonatomic, assign) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic, assign) NSUInteger rowCount;

@property (nonatomic, weak) id<MCUniversalCLFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
