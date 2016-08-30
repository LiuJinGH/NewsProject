//
//  LJNCBGestureRecognizer.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJNewsColumnButton.h"

@class LJNewsColumnButton;

@interface LJNCBGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, weak) LJNewsColumnButton *button;

@end
