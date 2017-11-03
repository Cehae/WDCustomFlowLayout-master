//
//  WDPhotoCell.m
//  WDCustomFlowLayoutDemo
//
//  Created by apple on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "WDPhotoCell.h"

@interface WDPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@end

@implementation WDPhotoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    _photoView.image = image;
}

@end
