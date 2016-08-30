//
//  LJNColumView.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/9.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJNColumnView.h"


@interface LJNColumnView ()

@property (weak, nonatomic) IBOutlet UIButton *editButon;


@end


@implementation LJNColumnView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    return [super initWithCoder:aDecoder];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    return [super initWithFrame:frame];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
}



- (IBAction)onclickNCEditButton:(UIButton *)sender {
    self.pushENCVC();

}


@end
