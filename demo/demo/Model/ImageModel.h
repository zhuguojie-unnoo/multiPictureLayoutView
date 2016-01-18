//
//  ImageModel.h
//  demo
//
//  Created by ios_zhu on 16/1/12.
//  Copyright © 2016年 ios_zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ImageModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@end
