//
//  LJNewsColumn.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJNewsColumn.h"

@implementation LJNewsColumn

#pragma mark -- NSObject 方法
-(NSString *)description{
    return [NSString stringWithFormat:@"NewsCloumn name is：%@ type is %ld sequence is %ld selected is %d", self.columnName, self.columnType, self.columnSequence, self.columnSelected];
}

@end
