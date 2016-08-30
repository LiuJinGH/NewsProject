//
//  LJNewsListCellOne.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/11.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LJNewsListCellOne : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (nonatomic, weak) UIViewController *holder;

@end
