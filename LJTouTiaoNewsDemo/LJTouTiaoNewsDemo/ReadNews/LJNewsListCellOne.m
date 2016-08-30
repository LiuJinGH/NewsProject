//
//  LJNewsListCellOne.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/11.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJNewsListCellOne.h"

@interface LJNewsListCellOne ()

@property (weak, nonatomic) IBOutlet UIButton *reportBt;

@end


@implementation LJNewsListCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupReportBt];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置反馈按钮
-(void)setupReportBt{
    //
    CGSize btSize = self.reportBt.frame.size ;
    
    CALayer *layer = self.reportBt.layer;
    layer.cornerRadius = btSize.width / 2 - 5 ;
    layer.borderWidth = 2.0;
    layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.reportBt addTarget:self action:@selector(toReportBt:) forControlEvents:UIControlEventTouchUpInside];
}

//反馈事件
-(void) toReportBt:(UIButton *) sender{
    
    NSLog(@"用户反馈新闻信息");
    
    __block UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不喜欢这则新闻？" message:@"选择不喜欢的原因，以便为您推荐更适合您的新闻！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不小心点错了！☺" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *submit = [UIAlertAction actionWithTitle:@"提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"谢谢您的反馈" message:@"提交成功，以后此类新闻不再向您推荐！！！" preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction *cancel2 = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
        [alert2 addAction:cancel2];
        
        [self.holder presentViewController:alert2 animated:YES completion:nil];
    }];
    [alert addAction:cancel];
    [alert addAction:submit];
    
    [self.holder presentViewController:alert animated:YES completion:nil];
}
























@end
