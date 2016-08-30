

//
//  LJSignUpVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/25.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJSignUpVC.h"

@interface LJSignUpVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listView;

@end

@implementation LJSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
}

- (IBAction)backTo:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark -- UITableViewDelegate 和 UITableViewDataSource 方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"FirstName"];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"LastName"];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"EmailAddress"];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"UserName"];
            break;
        case 4:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Password"];
            break;
        case 5:
            cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmPassword"];
            break;
        default:
            break;
    }
    
    
    return cell;
}




@end
