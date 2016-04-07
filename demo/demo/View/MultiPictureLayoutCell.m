//
//  MultiPictureLayoutCell.m
//  demo
//
//  Created by ios_zhu on 16/1/15.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import "MultiPictureLayoutCell.h"
#import "MultiPictureLayoutView.h"


@interface MultiPictureLayoutCell ()
{
    MultiPictureLayoutView *_multiPictureLayoutView;
}
@end


@implementation MultiPictureLayoutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //  添加多图控件到 cell 上
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MultiPictureLayoutView *multiPictureLayoutView = [[MultiPictureLayoutView alloc] init];
        _multiPictureLayoutView = multiPictureLayoutView;
        [self.contentView addSubview:_multiPictureLayoutView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //  设置多图控件的 frame
    _multiPictureLayoutView.frame = self.bounds;
    _multiPictureLayoutView.pictures = _pictures;
}

- (void)dealloc
{
    //  做多图控件的消除 当 cell 为 nil 的时候调用
    [_multiPictureLayoutView free];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    //  cell 重用时清空数据
    [_multiPictureLayoutView free];
}

//  返回 cell 的高度
+ (CGFloat)heightAtRow:(NSInteger)row withDataSourceArray:(NSArray *)dataSourceArray withWidthOfTableView:(CGFloat)tableViewWidth
{
    NSArray *pictures = dataSourceArray[row];
    CGFloat height = [MultiPictureLayoutView heightFromImageNumber:pictures.count withWidth:tableViewWidth];
    return height;
}

//  返回所有 cell 的高度数组
+ (NSArray *)heightsFromTableViewWidth:(CGFloat)tableViewWidth withDataSourceArray:(NSArray *)dataSourceArray
{
    NSMutableArray *imageSizeArray = [NSMutableArray array];

    for (NSArray *imageArray in dataSourceArray) {
        CGFloat height = [MultiPictureLayoutView heightFromImageNumber:imageArray.count withWidth:tableViewWidth];
        [imageSizeArray addObject:[NSNumber numberWithFloat:height]];
    }

    return imageSizeArray;
}

@end
