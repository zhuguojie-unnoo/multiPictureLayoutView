//
//  MultiPictureLayoutView.m
//  demo
//
//  Created by ios_zhu on 16/1/15.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import "MultiPictureLayoutView.h"
#import "UIImageView+WebCache.h"


#define SPLITLINE_WIDTH   1
#define IMAGE_URL   @"imageUrl"


@interface MultiPictureLayoutView ()
{
    BOOL _isInited;
    NSMutableArray *_imageViewArray;
}

@end


@implementation MultiPictureLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        _imageViewArray = [NSMutableArray array];
        [self creatImageViews];
        _isInited = YES;
    }
    
    return self;
}

- (void)creatImageViews
{
    for (NSInteger index = 0; index < 9; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;

        [self addSubview:imageView];
        [_imageViewArray addObject:imageView];
    }
}


- (void)setPictures:(NSArray *)pictures
{
    NSInteger count = pictures.count;
    
    if (count == 0) {
        [self free];
        
        return;
    }
    
    count = MIN(count, 9);
    _pictures = [pictures subarrayWithRange:NSMakeRange(0, count)];
    _isInited = NO;
    
    [self setNeedsLayout];
}

- (void)free
{
    _isInited = NO;
    _pictures = nil;
    
    for (UIImageView *imageView in _imageViewArray) {
        imageView.image = nil;
        [imageView sd_cancelCurrentImageLoad];
        imageView.frame = CGRectZero;
        imageView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    if (_isInited || (width == 0)) {
        return;
    }
    
    _isInited = YES;
    
    //  以下代码为计算 imageView 的布局
    NSInteger count = _pictures.count;
    NSArray *imagesFrameArray = [[self class] layoutSubviewsCustoms:count withItemWidth:width];
    
    for (NSInteger index = 0; index < count; index++) {
        NSDictionary *imageDict = _pictures[index];
        UIImageView *imageView = _imageViewArray[index];
        
        imageView.hidden = YES;
        imageView.frame = [imagesFrameArray[index] CGRectValue];
        imageView.hidden = NO;
        
        NSString *imageUrl = [imageDict objectForKey:IMAGE_URL];
        if (imageUrl.length > 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
    }
}


#pragma mark - 计算 frame，返回装有 frame 的数组

+ (NSArray *)layoutSubviewsCustoms:(NSInteger )count withItemWidth:(CGFloat)width
{
    if (count == 0) {
        return nil;
    }
    
    CGFloat originY = 0;
    NSMutableArray *array = [NSMutableArray array];
    
    switch (count) {
        case 1:{
            originY = [MultiPictureLayoutView layoutOneStyleView:array withOriginY:0 withItemWidth:width];
            break;
        }
            
        case 2: {
            originY = [MultiPictureLayoutView layoutTwoStyleView:array withOriginY:0 withItemWidth:width];
            break;
        }
            
        case 3: {
            originY = [MultiPictureLayoutView layoutNoEqualStyleView:array withOriginY:0 withItemWidth:width];
            break;
        }
            
        case 4: {
            originY = [MultiPictureLayoutView layoutOneStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
            
        }
            
        case 5: {
            originY = [MultiPictureLayoutView layoutTwoStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
        }
            
        case 6: {
            originY = [MultiPictureLayoutView layoutNoEqualStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array  withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
        }
            
        case 7: {
            originY = [MultiPictureLayoutView layoutOneStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY: originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
        }
            
        case 8: {
            originY = [MultiPictureLayoutView layoutTwoStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY: originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
        }
            
        case 9: {
            originY = [MultiPictureLayoutView layoutNoEqualStyleView:array withOriginY:0 withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            originY = [MultiPictureLayoutView layoutThreeEqualStyleView:array withOriginY:originY + SPLITLINE_WIDTH withItemWidth:width];
            break;
        }
            
        default: {
            break;
        }
    }
    
    NSArray *imageFrameArray = [NSArray arrayWithArray:array];
    
    return imageFrameArray;
}

+ (CGFloat)layoutOneStyleView:(NSMutableArray *)array withOriginY:(CGFloat)originY withItemWidth:(CGFloat)width
{
    CGFloat baseWidth = width;
    CGFloat threeWidth = (baseWidth - SPLITLINE_WIDTH * 2) / 3.0;
    CGFloat threeBigWidth = baseWidth - threeWidth - SPLITLINE_WIDTH;
    
    CGRect frame = CGRectMake(0, originY, baseWidth, threeBigWidth);
    [array addObject:[NSValue valueWithCGRect:frame]];
    
    return originY + threeBigWidth;
}

+ (CGFloat)layoutTwoStyleView:(NSMutableArray *)array withOriginY:(CGFloat)originY withItemWidth:(CGFloat)width
{
    CGFloat baseWidth = width;
    CGFloat twoWidth = (baseWidth - SPLITLINE_WIDTH) * 0.5;
    CGRect frame = CGRectMake(0, originY, twoWidth, twoWidth);
    CGRect SecondFrame = CGRectMake(twoWidth + SPLITLINE_WIDTH, originY, twoWidth, twoWidth);
    
    [array addObject:[NSValue valueWithCGRect:frame]];
    [array addObject:[NSValue valueWithCGRect:SecondFrame]];
    
    return originY + twoWidth;
}

+ (CGFloat)layoutThreeEqualStyleView:(NSMutableArray *)array withOriginY:(CGFloat)originY withItemWidth:(CGFloat)width
{
    CGFloat baseWidth = width;
    CGFloat threeWidth = (baseWidth - SPLITLINE_WIDTH*2) / 3.0;
    
    CGRect frame = CGRectMake(0, originY, threeWidth, threeWidth);
    CGRect secondframe = CGRectMake(threeWidth + SPLITLINE_WIDTH, originY, threeWidth, threeWidth);
    CGRect threeFrame = CGRectMake((threeWidth + SPLITLINE_WIDTH) * 2, originY, threeWidth, threeWidth);
    
    [array addObject:[NSValue valueWithCGRect:frame]];
    [array addObject:[NSValue valueWithCGRect:secondframe]];
    [array addObject:[NSValue valueWithCGRect:threeFrame]];
    
    return originY + threeWidth;
}

+ (CGFloat)layoutNoEqualStyleView:(NSMutableArray *)array withOriginY:(CGFloat)originY withItemWidth:(CGFloat)width
{
    CGFloat baseWidth = width;
    CGFloat threeWidth = (baseWidth - SPLITLINE_WIDTH * 2) / 3.0;
    CGFloat threeBigWidth = baseWidth - threeWidth - SPLITLINE_WIDTH;
    
    CGRect frame = CGRectMake(0, originY, threeBigWidth, threeBigWidth);
    CGRect secondeFrame = CGRectMake(threeBigWidth + SPLITLINE_WIDTH, originY, threeWidth, threeWidth);
    CGRect threeFrame = CGRectMake(threeBigWidth + SPLITLINE_WIDTH, threeWidth + SPLITLINE_WIDTH + originY, threeWidth, threeWidth);
    
    [array addObject:[NSValue valueWithCGRect:frame]];
    [array addObject:[NSValue valueWithCGRect:secondeFrame]];
    [array addObject:[NSValue valueWithCGRect:threeFrame]];
    
    return threeBigWidth;
}


+ (CGFloat)heightFromImageNumber:(NSInteger)number withWidth:(CGFloat)width
{
    CGFloat baseWidth;
    if (width != 0) {
        baseWidth = width;
    }
    else {
        return 0;
    }
    
    CGFloat twoWidth = (baseWidth - SPLITLINE_WIDTH) * 0.5;
    CGFloat threeWidth = (baseWidth - SPLITLINE_WIDTH * 2) / 3.0;
    CGFloat threeBigWidth = baseWidth - threeWidth - SPLITLINE_WIDTH;
    
    CGFloat height;
    switch (number) {
        case 1: {
            height = threeBigWidth;
            break;
        }
            
        case 2: {
            height = twoWidth;
            break;
        }
            
        case 3: {
            height = threeBigWidth;
            break;
        }
            
        case 4: {
            height = threeBigWidth + threeWidth + SPLITLINE_WIDTH;
            break;
        }
            
        case 5: {
            height = twoWidth + threeWidth + SPLITLINE_WIDTH;
            break;
        }
            
        case 6: {
            height = threeBigWidth + threeWidth + SPLITLINE_WIDTH;
            break;
        }
            
        case 7: {
            height = threeBigWidth + threeWidth * 2 + SPLITLINE_WIDTH * 2;
            break;
        }
            
        case 8: {
            height = twoWidth + threeWidth * 2 + SPLITLINE_WIDTH * 2;
            break;
        }
            
        case 9: {
            height = threeBigWidth + threeWidth * 2 + SPLITLINE_WIDTH * 2;
            break;
        }
            
        default: {
            height = 0;
        }
    }
    
    return height;
}

@end
