//
//  MultiPictureLayoutView.h
//  demo
//
//  Created by ios_zhu on 16/1/15.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultiPictureLayoutView : UIView

@property (nonatomic, strong) NSArray *pictures;

+ (CGFloat)heightFromImageNumber:(NSInteger)number withWidth:(CGFloat)width;

- (void)free;

@end
