//
//  MultiPictureLayoutCell.h
//  demo
//
//  Created by ios_zhu on 16/1/15.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultiPictureLayoutCell : UITableViewCell

@property (nonatomic, strong) NSArray *pictures;

+ (CGFloat)heightAtRow:(NSInteger)row withDataSourceArray:(NSArray *)dataSourceArray withWidthOfTableView:(CGFloat)tableViewWidth;

+ (NSArray *)heightsFromTableViewWidth:(CGFloat)tableViewWidth withDataSourceArray:(NSArray *)dataSourceArray;

@end
