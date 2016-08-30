//
//  LJNewsColumnButton.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJNewsColumnButton.h"

@interface LJNewsColumnButton ()



@end

@implementation LJNewsColumnButton

//属性editSelected 存取函数
@synthesize editSelected = _editSelected;
-(void)setEditSelected:(BOOL)editSelected{
    _editSelected = editSelected;
    
    if (self.editSelected) {
        [self showSmallButton];
    }else{
        [self.smallButton removeFromSuperview];
    }
}
-(BOOL)isEditSelected{
    return _editSelected;
}

//懒加载创建smallButton
-(UIButton *)smallButton{
    if (!_smallButton) {
        _smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _smallButton;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"新闻主题名：%@，排序号：%ld，类型：%ld", self.newsColumn.columnName, (long)self.newsColumn.columnSequence, (long)self.newsColumn.columnType];
}

//哈希值
-(NSUInteger)hash{
    return self.newsColumn.columnSequence;
}

//数组排序比较器
-(NSComparisonResult)compareWithNewsColumnSequence:(LJNewsColumnButton *)other{
    
    if (self.newsColumn.columnSequence == other.newsColumn.columnSequence) {
        return NSOrderedSame;
    }else if (self.newsColumn.columnSequence > other.newsColumn.columnSequence){
        return NSOrderedDescending;
    }else{
        return NSOrderedAscending;
    }
    
}

//设置按钮框架时，也设置了按钮边界
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    _panPoint.beginX = frame.origin.x;
    _panPoint.beginY = frame.origin.y;
    _panPoint.endX = frame.origin.x + frame.size.width;
    _panPoint.endY = frame.origin.y + frame.size.height;
    
}

//显示小按钮
-(void)showSmallButton{
    
    [self addSubview:self.smallButton];
    [self setNeedsDisplay];
}

@end
