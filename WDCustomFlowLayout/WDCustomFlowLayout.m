//
//  WDCustomFlowLayout.m
//  WDCustomFlowLayoutDemo
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WDCustomFlowLayout.h"

@implementation WDCustomFlowLayout

// collectionView第一次布局时调用，collectionView刷新的时候也会调用
- (void)prepareLayout
{
    NSLog(@"%s",__func__);
    
    [super prepareLayout];
    
}

// 返回指定区域内的UICollectionViewLayoutAttributes，一个UICollectionViewLayoutAttributes对应一个Cell
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
    
    // 设置cell尺寸 => UICollectionViewLayoutAttributes
    // 越靠近中心点,距离越小,缩放越大
    // 求cell与中心点距离
    
    // 1.获取当前显示cell的布局
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        // 2.计算中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        
        // 3.计算比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs;
    
}

// 用户手指一松开就会调用，用来确定每次滚动的最终偏移量
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    NSLog(@"%s",__func__);
    
    // 拖动比较快 最终偏移量 不等于 手指离开时偏移量
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    // 最终偏移量
    CGPoint targetP = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    // 0.获取最终显示的区域
    CGRect targetRect = CGRectMake(targetP.x, 0, collectionW, MAXFLOAT);
    
    // 1.获取最终显示的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    // 获取最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 获取距离中心点距离:注意:应该用最终的x
        CGFloat delta = (attr.center.x - targetP.x) - self.collectionView.bounds.size.width * 0.5;
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    // 移动间距
    targetP.x += minDelta;
    
    if (targetP.x < 0) {
        targetP.x = 0;
    }
    
    return targetP;
}

// 在滚动的时候是否允许刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    NSLog(@"%s",__func__);
    
    return YES;
}

// 计算collectionView滚动范围
- (CGSize)collectionViewContentSize{
    
    NSLog(@"%s",__func__);

    return [super collectionViewContentSize];
}

@end
