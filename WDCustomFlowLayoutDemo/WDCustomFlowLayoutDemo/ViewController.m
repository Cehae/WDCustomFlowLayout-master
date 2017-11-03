//
//  ViewController.m
//  WDCustomFlowLayoutDemo
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

#import "WDCustomFlowLayout.h"
#import "WDPhotoCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

#define ScreenW [UIScreen mainScreen].bounds.size.width

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置WDCustomFlowLayout
    WDCustomFlowLayout *layout = [[WDCustomFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(160, 160);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = (ScreenW - 160) * 0.5;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 50;
    
    
    // 创建UICollectionView
    UICollectionView *collectionView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor brownColor];
    collectionView.center = self.view.center;
    collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    // 注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WDPhotoCell class])  bundle:nil] forCellWithReuseIdentifier:ID];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WDPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

@end
