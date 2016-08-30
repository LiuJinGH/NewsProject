//
//  LJUserManagerVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJUserManagerVC.h"

@interface LJUserManagerVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *listView;

@end

@implementation LJUserManagerVC

-(void) setupHeader{
    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.width / 2.0;
    
    CALayer *layer = self.headerView.layer;
    
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 3;
    layer.cornerRadius = self.headerView.frame.size.width / 2.0;
    
}

- (IBAction)onClickHeaderButton:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            NSLog(@"收藏按钮");
            break;
        case 2:
            NSLog(@"夜间按钮");
            break;
        case 3:
            NSLog(@"设置按钮");
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeader];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    //
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark -- UITableViewDelegate 和 UITableViewDataSource 方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    UILabel *label = [cell viewWithTag:100];
    label.layer.cornerRadius = label.frame.size.height / 2.0;
    label.layer.masksToBounds = YES;
    
    UIImageView *imageView = [cell viewWithTag:101];
    UIImage *image = [UIImage imageNamed:@"message"];
    switch (indexPath.row) {
        case 1:
            image = [UIImage imageNamed:@"friend"];
            label.backgroundColor = [UIColor colorWithRed:224/255.0 green:64/255.0 blue:49/255.0 alpha:1.0];
            ((UILabel *)[cell viewWithTag:103]).text = @"Friend Request";
            break;
        
        case 2:
            image = [UIImage imageNamed:@"task"];
            label.backgroundColor = [UIColor colorWithRed:235/255.0 green:170/255.0 blue:50/255.0 alpha:1.0];
            ((UILabel *)[cell viewWithTag:103]).text = @"Task";
            
        default:
            break;
    }
    
    imageView.image = image;
    return cell;
}

@end
