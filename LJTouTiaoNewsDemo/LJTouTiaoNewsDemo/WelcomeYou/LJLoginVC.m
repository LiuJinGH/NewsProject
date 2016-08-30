//
//  LJLoginVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJLoginVC.h"

@interface LJLoginVC ()

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet UIView *loginButtonView;

@end

@implementation LJLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUserView:self.nameView];
    [self setUpUserView:self.passView];
    [self setUpUserView:self.loginButtonView];
}

- (IBAction)loginUser:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LJTouTiaoNewsMainVC"];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:vc];
    
}

-(void)setUpUserView:(UIView *) view{
    CGSize size = view.frame.size;
    view.layer.cornerRadius = size.height/2.0;
}



@end
