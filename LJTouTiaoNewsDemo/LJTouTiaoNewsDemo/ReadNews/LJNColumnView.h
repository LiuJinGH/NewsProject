//
//  LJNColumView.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/9.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^BLOCK)(void);

@interface LJNColumnView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *newsColumView;

@property (nonatomic) BLOCK pushENCVC;

@end
