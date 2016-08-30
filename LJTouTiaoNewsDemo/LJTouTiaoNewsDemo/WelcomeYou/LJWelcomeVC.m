//
//  LJWelcomeVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJWelcomeVC.h"
#import "LJLoginVC.h"

@class LJLoginVC;

#define NUM (4)

@interface LJWelcomeVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *welcomeView;

@end

@implementation LJWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupWelcomeView];
}

-(void) setupWelcomeView{
    NSString *imageName = @"welcome";
    
    CGSize mainSize = self.welcomeView.frame.size;
    
    //加载图片
    for (int i = 0; i< NUM; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", imageName, i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setFrame:CGRectMake(i * mainSize.width, 0, mainSize.width, mainSize.height)];
        
        if (i==3) {
            [imageView setUserInteractionEnabled:YES];
            [self setupGoLoginButton:imageView];
        }
        [self.welcomeView setAlpha:1.0];
        [self.welcomeView addSubview:imageView];
    }
    
    //配置参数
    self.welcomeView.contentSize = CGSizeMake(NUM * mainSize.width, 0);
    
}

-(void)setupGoLoginButton:(UIImageView *) imageView{
    CGSize buttonSize = CGSizeMake(200, 30);
    CGSize viewSize = imageView.frame.size;
    CGPoint buttonCenter = CGPointMake(viewSize.width/2, viewSize.height*3/4);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(300, 300, buttonSize.width, buttonSize.height)];
    [button setCenter:buttonCenter];
    [button setTitle:@"开启心之旅" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:button];
}

-(void)goLogin{
    
    LJLoginVC *ljlVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LJLoginVC"];
    self.view.window.rootViewController = ljlVC;
    
}
@end
