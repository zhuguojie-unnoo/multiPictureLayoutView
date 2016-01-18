//
//  ViewController.m
//  demo
//
//  Created by ios_zhu on 16/1/5.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import "ViewController.h"
#import "ImageModel.h"
#import "MultiPictureLayoutCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define IMAGE_URL   @"imageUrl"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataSourceFileArray;    //  数据源
    NSArray *_heightArray;                   //  cell 的 height 数组
    UITableView *_tableView;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    //  初始化控件
    [self initTableView];
    //  加载数据
    [self reloadData];
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)reloadData
{
    NSMutableArray *array = [NSMutableArray array];
    ImageModel *imageModel = [[ImageModel alloc] init];
    
    imageModel.imageUrl = @"http://pic9.nipic.com/20100820/5462876_111802062730_2.jpg";
    imageModel.height = 280;
    imageModel.width = 250;
    [array addObject:imageModel];
    
    ImageModel *imageModel1 = [[ImageModel alloc] init];
    imageModel1.imageUrl = @"http://fujian.86516.com/forum/201209/28/16042484m9y9izwbrwuixj.jpg";
    imageModel1.height = 280;
    imageModel1.width = 250;
    [array addObject:imageModel1];
    
    ImageModel *imageModel2 = [[ImageModel alloc] init];
    imageModel2.imageUrl = @"http://pic10.nipic.com/20101014/4768360_230901509000_2.jpg";
    imageModel2.height = 280;
    imageModel2.width = 250;
    [array addObject:imageModel2];
    
    ImageModel *imageModel3 = [[ImageModel alloc] init];
    imageModel3.imageUrl = @"http://pic5.nipic.com/20100121/4183722_103138000079_2.jpg";
    imageModel3.height = 280;
    imageModel3.width = 250;
    [array addObject:imageModel3];
    
    ImageModel *imageModel4 = [[ImageModel alloc] init];
    imageModel4.imageUrl = @"http://pic4.nipic.com/20091104/2645351_152840096265_2.jpg";
    imageModel4.height = 280;
    imageModel4.width = 250;
    [array addObject:imageModel4];
    
    ImageModel *imageModel5 = [[ImageModel alloc] init];
    imageModel5.imageUrl = @"http://pic12.nipic.com/20110217/6757620_105953632124_2.jpg";
    imageModel5.height = 280;
    imageModel5.width = 250;
    [array addObject:imageModel5];
    
    ImageModel *imageModel6 = [[ImageModel alloc] init];
    imageModel6.imageUrl = @"http://pic19.nipic.com/20120310/8061225_093309101000_2.jpg";
    imageModel6.height = 280;
    imageModel6.width = 250;
    [array addObject:imageModel6];
    
    ImageModel *imageModel7 = [[ImageModel alloc] init];
    imageModel7.imageUrl = @"http://pica.nipic.com/2008-01-20/20081201605887_2.jpg";
    imageModel7.height = 280;
    imageModel7.width = 250;
    [array addObject:imageModel7];
    
    ImageModel *imageModel8 = [[ImageModel alloc] init];
    imageModel8.imageUrl = @"http://pica.nipic.com/2007-10-05/2007105235438127_2.jpg";
    imageModel8.height = 280;
    imageModel8.width = 250;
    [array addObject:imageModel8];
    
    NSMutableArray *dictArray = [NSMutableArray array];
    for (ImageModel *imageBaseModel in array) {
        NSMutableDictionary *imageDictionary = [[NSMutableDictionary alloc]init];
        [imageDictionary setValue:imageBaseModel.imageUrl forKey:IMAGE_URL];
        [imageDictionary setValue:[NSString stringWithFormat:@"%lf", imageBaseModel.height] forKey:@"height"];
        [imageDictionary setValue:[NSString stringWithFormat:@"%lf", imageBaseModel.width] forKey:@"width"];
        [dictArray addObject:imageDictionary];
    }
    
    _dataSourceFileArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 100; i++) {
        NSInteger index = i % 10;
        if (index == 0) {
            index = 1;
        }
    
        NSArray *pictures = [dictArray subarrayWithRange:NSMakeRange(0, 9)];
        [_dataSourceFileArray addObject:pictures];
    }
    
    _heightArray = [MultiPictureLayoutCell heightsFromTableViewWidth:CGRectGetWidth(_tableView.frame) withDataSourceArray:_dataSourceFileArray];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [MultiPictureLayoutCell heightAtRow:indexPath.row withDataSourceArray:_dataSourceFileArray withWidthOfTableView:CGRectGetWidth(tableView.frame)];
    //  可以通过数组返回
//    CGFloat height = _heightArray[indexPath.row];

    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceFileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    MultiPictureLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[MultiPictureLayoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.pictures = _dataSourceFileArray[indexPath.row];
    
    return cell;
}

@end
