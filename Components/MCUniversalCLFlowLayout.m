//
//  MCUniversalCLFlowLayout.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2020/7/24.
//  Copyright © 2020 Apeman. All rights reserved.
//

#import "MCUniversalCLFlowLayout.h"
#import <stdio.h>
#import <stdlib.h>

@interface MCUniversalCLFlowLayout ()

@property (strong, nonatomic) NSMutableArray *allAttributes;

@end

@implementation MCUniversalCLFlowLayout

- (void)prepareLayout
{
    
    [super prepareLayout];
    
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    NSMutableArray *tmp = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        
        if (CGRectIntersectsRect(attr.frame, rect)) {
            if (visibleRect.origin.x == 0) {
                [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attr.indexPath page:0];
            } else {
                // 除法取整 取余数
                ldiv_t x = ldiv(visibleRect.origin.x, visibleRect.size.width);
                if (x.quot > 0 && x.rem > 0) {
                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attr.indexPath page:x.quot + 1];
                }
                if (x.quot > 0 && x.rem == 0) {
                    [self.delegate collectionView:self.collectionView layout:self cellCenteredAtIndexPath:attr.indexPath page:x.quot];
                }
            }
        }
        
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}

/// 根据item，计算目标item的位置
/// @param item 参照item
/// @param x 水平偏移
/// @param y 垂直偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y {
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

/// 根据偏移量计算item
/// @param x 水平偏移
/// @param y 垂直偏移
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y {
    NSUInteger item = x * self.rowCount + y;
    return item;
}

@end
