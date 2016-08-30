//
//  LJNewsColumn.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJNewsColumn : NSObject

@property (nonatomic) NSString *columnName;
@property (nonatomic) NSInteger columnType;
@property (nonatomic) Boolean columnSelected;
@property (nonatomic) NSInteger columnSequence;

@end
