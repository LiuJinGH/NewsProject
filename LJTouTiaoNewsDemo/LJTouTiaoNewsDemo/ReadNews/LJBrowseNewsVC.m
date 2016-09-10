//
//  LJBrowseNewsVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/9.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJBrowseNewsVC.h"
#import "LJNColumnView.h"
#import "LJEditNewsColumnVC.h"
#import "LJNewsColumnStore.h"
#import "NewsColumnStore/LJNewsColumn.h"
#import "LJNewsListCellOne.h"

@class LJNewsListCellOne;
@class LJNewsColumn;
@class LJNewsColumnStore;
@class LJEditNewsColumnVC;
@class LJNColumnView;

@interface LJBrowseNewsVC ()<UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic) LJNColumnView *newsColum;

@property (nonatomic) UITableView *newsTableView;
@property (nonatomic) UITableView *panRightTableView;
@property (nonatomic) UITableView *panLeftTableView;

@property (nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation LJBrowseNewsVC

//设置左右TableView
-(UITableView *)setupPanTableWithRect:(CGRect) rect andTag:(NSInteger) tag{
    
    UITableView *table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tag = tag;
    table.backgroundColor = [UIColor colorWithRed:255/255.0 green:221/255.0 blue:173/255.0 alpha:1.0];
    
    [self addGestureToTable:table];

    return table;
}

//向TableView添加手势
-(void)addGestureToTable:(UITableView *)table{
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTableView:)];
    panGesture.delegate = self;
    panGesture.cancelsTouchesInView = NO;
    
    [table addGestureRecognizer:panGesture];

}

-(void)panTableView:(UIPanGestureRecognizer *)gr{
    
    static CGPoint panCenter;
    static CGPoint rightCenter;
    static CGPoint leftCenter;
    
    static CGFloat tempX;
    static CGFloat tempY;
    
    if (gr.state == UIGestureRecognizerStateBegan) {
        
        tempX = 0;
        tempY = 0;
        
        panCenter = self.newsTableView.center;
        rightCenter = self.panRightTableView.center;
        leftCenter = self.panLeftTableView.center;
        
    }else if (gr.state == UIGestureRecognizerStateEnded){
        
        CGFloat xOffset = self.newsTableView.center.x - panCenter.x;
        BOOL panFlag = xOffset < 0 ? 1 : 0;
        xOffset = fabs(xOffset);
        
        if (xOffset > self.view.frame.size.width / 2.0) {
            
            if (panFlag) {

                UITableView *table = self.panLeftTableView;
                self.panLeftTableView = self.newsTableView;
                self.newsTableView = self.panRightTableView;
                self.panRightTableView = table;

            }else{
                
                UITableView *table = self.panRightTableView;
                self.panRightTableView = self.newsTableView;
                self.newsTableView = self.panLeftTableView;
                self.panLeftTableView = table;
            
            }
            
        }
//        [self.newsTableView setFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        self.newsTableView.center = panCenter;
        self.panRightTableView.center = rightCenter;
        self.panLeftTableView.center = leftCenter;
        
    }else if (gr.state == UIGestureRecognizerStateChanged){
        
        CGPoint translation = [gr translationInView:self.view];
        
        tempX += translation.x;
        tempY += translation.y;
        
        tempX = fabs(tempX);
        tempY = fabs(tempY);
        
        if(tempX >=5 && tempY <=20){
            tempX = 0;
            
            CGPoint center = self.newsTableView.center;
            center = CGPointMake(center.x + translation.x, center.y);
            self.newsTableView.center = center;
            
            center = self.panRightTableView.center;
            center = CGPointMake(center.x + translation.x, center.y);
            self.panRightTableView.center = center;
            
            center = self.panLeftTableView.center;
            center = CGPointMake(center.x + translation.x, center.y);
            self.panLeftTableView.center = center;
            
        }
        
        
        
        [gr setTranslation:CGPointZero inView:self.view];
    }
}

//
- (void)viewDidLoad {
    [super viewDidLoad];
    //新闻列表视图
    self.newsTableView = [self setupPanTableWithRect:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) andTag:201];
    [self.view addSubview:self.newsTableView];
    
    self.panLeftTableView = [self setupPanTableWithRect:CGRectMake(-self.view.frame.size.width, 64, self.view.frame.size.width, self.view.frame.size.height-64) andTag:203];
    [self.view addSubview:self.panLeftTableView];
    
    self.panRightTableView = [self setupPanTableWithRect:CGRectMake(self.view.frame.size.width, 64, self.view.frame.size.width, self.view.frame.size.height-64) andTag:202];
    [self.view addSubview:self.panRightTableView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupNewsColumn];
    
    //加载新闻列表项视图
    UINib *nib = [UINib nibWithNibName:@"LJNewsListCellOne" bundle:nil];
    
    [self.newsTableView registerNib:nib forCellReuseIdentifier:@"LJNewsListCellOne"];
    [self.panRightTableView registerNib:nib forCellReuseIdentifier:@"LJNewsListCellOne"];
    [self.panLeftTableView registerNib:nib forCellReuseIdentifier:@"LJNewsListCellOne"];
    
}

//设置新闻栏目
-(void) setupNewsColumn{
    [LJNewsColumnStore sharedInstanceBySingleton];
    
    //从NIB文件创建LJNColumnView对象
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LJNColumnView" owner:nil options:nil];
    self.newsColum = (LJNColumnView *) nib[0];
    [self.newsColum setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    //设置新闻栏目编辑按钮执行事件
    __block UIStoryboard *storyboard = self.storyboard;
    __block UINavigationController *NC = self.navigationController;
    //设置新闻栏目按钮执行的操作
    self.newsColum.pushENCVC = ^{
        LJEditNewsColumnVC *ENCVC = [storyboard instantiateViewControllerWithIdentifier:@"LJEditNewsColumnVC"];
        [NC presentViewController:ENCVC animated:YES completion:nil];
    };
    
    [self loadNewsColunm];
    
    [self.view addSubview:self.newsColum];
}

//加载新闻栏目
-(void)loadNewsColunm{
    //获取新闻栏目的数据对象
    NSArray *allNewsColumns = [[LJNewsColumnStore sharedInstanceBySingleton] allNewsColumns];
    
    UIScrollView *newsScrollView = self.newsColum.newsColumView;
    
    int i = 0;
    //新闻栏按钮的宽度
    NSLog(@"%f", newsScrollView.frame.size.width);
    int buttonWidth = CGRectGetWidth(newsScrollView.frame) / 4.0;
    CGSize viewSize = newsScrollView.frame.size;
    //向新闻栏添加按钮
    for (LJNewsColumn *newsColumn in allNewsColumns) {
        
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        CALayer *layer = [CALayer layer];
        
        //设置按钮的位置
        [button setFrame:CGRectMake(0 + i * buttonWidth, 0, buttonWidth, viewSize.height-18)];
        
        CGSize size = button.frame.size;
        layer.frame = CGRectMake(8, 4, size.width-16, size.height-8);
        layer.cornerRadius = layer.frame.size.height / 2.0;
        layer.borderColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 2.0;
        [button.layer addSublayer:layer];
        
        [button setTitle:newsColumn.columnName  forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        
        [newsScrollView addSubview:button];
        i++;
    }
    
    newsScrollView.contentSize = CGSizeMake(allNewsColumns.count * buttonWidth, 0);
    //指示栏关闭
    newsScrollView.showsVerticalScrollIndicator = NO;
    newsScrollView.showsHorizontalScrollIndicator = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
    //显示tabBar
    [self.tabBarController.tabBar setHidden:NO];
    
}

#pragma mark -- UITableViewDelegate 和 UITableViewDataSource 方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LJNewsListCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"LJNewsListCellOne"];
    cell.holder = self;

    switch (tableView.tag) {
        case 201:
            cell.newsTitle.text = @"第一个Table";
            break;
        case 202:
            cell.newsTitle.text = @"第二个Table";
            break;
        case 203:
            cell.newsTitle.text = @"第三个Table";
            break;
        default:
            break;
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LJNewsListCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"LJNewsListCellOne"];
    
    return CGRectGetHeight(cell.frame);
    
}

#pragma mark -- UIGestureRecognizerDelegate 方法

//当两个拖动手势冲突时，要实现这个方法来避免冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (gestureRecognizer == self.newsTableView.gestureRecognizers[1] ||gestureRecognizer == self.newsTableView.gestureRecognizers[2]) {
        return YES;
    }
    
    return NO;
    
}






@end
