//
//  LJNewsColumnButton.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJNewsColumn.h"

@class LJNewsColumn;

@interface LJNewsColumnButton : UIButton<UIGestureRecognizerDelegate>

typedef struct{
    CGFloat beginX;
    CGFloat beginY;
    CGFloat endX;
    CGFloat endY;
}LJPanPoint;

@property (nonatomic, getter=isEditSelected) BOOL editSelected;
@property (nonatomic) UIButton *smallButton;
@property (nonatomic) LJNewsColumn *newsColumn;
@property (nonatomic, assign) LJPanPoint panPoint;

-(NSComparisonResult)compareWithNewsColumnSequence:(LJNewsColumnButton *)other;

@end
