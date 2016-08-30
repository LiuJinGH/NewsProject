//
//  LJEditNewsColumnVC.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#define OsideO (10)
#define BUTTONNUM (4)
#define VIEWWIDTH (self.view.frame.size.width)
#define VIEWHEIGHT (self.view.frame.size.height)
#define BUTTONWIDTH ((VIEWWIDTH - ((OsideO) * ((BUTTONNUM) + 1))) / (BUTTONNUM))
#define BUTTONHEIGHT (32)


#import "LJEditNewsColumnVC.h"
#import "NewsColumnStore/LJNewsColumnStore.h"
#import "NewsColumnStore/LJNewsColumn.h"
#import "NewsColumnStore/LJNewsColumnButton.h"
#import "NewsColumnStore/LJNCBGestureRecognizer.h"

@class LJNCBGestureRecognizer;
@class LJNewsColumnButton;
@class LJNewsColumn;
@class LJNewsColumnStore;

@interface LJEditNewsColumnVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *editNewsColumnSV;
@property (weak, nonatomic) IBOutlet UIView *allNewsColumnV;
@property (weak, nonatomic) IBOutlet UIView *newsColumnStoreV;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (nonatomic) BOOL editSelected;
@property (nonatomic) NSMutableArray<LJNewsColumnButton*> *newsColumnButtons;
@property (nonatomic) NSMutableArray<LJNewsColumnButton*> *newsColumnStoreButtons;


@end

@implementation LJEditNewsColumnVC

#pragma mark -- 存取方法

-(void)setEditSelected:(BOOL)editSelected{
    _editSelected = editSelected;
    
    if (_editSelected) {
        [self.editButton setTitle:@"完成" forState:UIControlStateNormal];

    }else{
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    for (LJNewsColumnButton *button in self.newsColumnButtons) {
        
        ;//这里增加抖动动画
        
        if (_editSelected) {
            button.editSelected = YES;
            button.userInteractionEnabled = YES;
        }else{
            button.editSelected = NO;
            button.userInteractionEnabled = NO;
        }
        
    }
    
    for (LJNewsColumnButton *button in self.newsColumnStoreButtons) {
        if (_editSelected) {
            button.userInteractionEnabled = YES;
        }else{
            button.userInteractionEnabled = NO;
        }
    }
}

-(NSMutableArray<LJNewsColumnButton *> *)newsColumnButtons{
    if (!_newsColumnButtons) {
        _newsColumnButtons = [NSMutableArray array];
    }
    return _newsColumnButtons;
}

-(NSMutableArray<LJNewsColumnButton *> *)newsColumnStoreButtons{
    if (!_newsColumnStoreButtons) {
        _newsColumnStoreButtons = [NSMutableArray array];
    }
    return _newsColumnStoreButtons;
}

#pragma mark -- ViewController方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    [self setupEditButton];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController setNavigationBarHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    [self loadNewsColumns];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.editSelected = NO;
}
#pragma mark -- LJEditNewsColumnVC  方法

-(LJNewsColumnButton *) buttonInstanceWithNewsColumn:(LJNewsColumn *)newsColumn{
    LJNewsColumnButton *tempButton = [LJNewsColumnButton buttonWithType:UIButtonTypeCustom];
    
    //设置按钮参数
    tempButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tempButton setNewsColumn:newsColumn];
    [tempButton setTitle:newsColumn.columnName forState:UIControlStateNormal];
    
    //设置按钮上的小按钮
    UIButton *smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smallButton setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    smallButton.frame = CGRectMake(BUTTONWIDTH-15, -5, 25, 25);
    [smallButton addTarget:self action:@selector(removeNewsColumnToStore:) forControlEvents:UIControlEventTouchUpInside];
    tempButton.smallButton = smallButton ;
    
    //已选择新闻栏目 设置拖动手势
    if (tempButton.newsColumn.columnSelected) {
        LJNCBGestureRecognizer *panGesture = [[LJNCBGestureRecognizer alloc] initWithTarget:self action:@selector(onpanButton:)];
        panGesture.delegate = self;
        panGesture.button = tempButton;
        [tempButton addGestureRecognizer:panGesture];
    }else{  //未选择新闻栏目 设置点击事件
        
        [tempButton addTarget:self action:@selector(addNewsColumnFromStore:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return tempButton;
}

//设置编辑按钮
-(void) setupEditButton{
    UIButton *bt = self.editButton;
    [bt addTarget:self action:@selector(onclickEdit:) forControlEvents:UIControlEventTouchUpInside];
    bt.layer.borderWidth = 2.0;
    bt.layer.cornerRadius = CGRectGetHeight(bt.frame) / 2;
    bt.layer.borderColor = [UIColor redColor].CGColor;
}

-(void) loadNewsColumns{
    NSArray *allNewsColumns = [[LJNewsColumnStore sharedInstanceBySingleton] allNewsColumns];
    NSArray *newsColumnStore = [[LJNewsColumnStore sharedInstanceBySingleton] newsColumnsStore];
    
    
    //加载已选择新闻栏目按钮  有拖动手势，但没有按钮点是事件
    for (LJNewsColumn *LJNC in allNewsColumns) {
        
        LJNewsColumnButton *tempButton = [self buttonInstanceWithNewsColumn:LJNC];
        
        //加入视图和数组
        [self.allNewsColumnV addSubview:tempButton];
        [self.newsColumnButtons addObject:tempButton];
    }
    self.newsColumnButtons = [[self.newsColumnButtons sortedArrayUsingSelector:@selector(compareWithNewsColumnSequence:)] mutableCopy];
    [self newsColumnButtonWillShowFromArray:self.newsColumnButtons];
    
    //加载未选择新闻栏目按钮  没有拖动手势，但有按钮点击事件
    for (LJNewsColumn *LJNC in newsColumnStore) {
        
        LJNewsColumnButton *tempButton = [self buttonInstanceWithNewsColumn:LJNC];
        
        //加入视图和数组
        [self.newsColumnStoreV addSubview:tempButton];
        [self.newsColumnStoreButtons addObject:tempButton];
    }
    self.newsColumnStoreButtons = [[self.newsColumnStoreButtons sortedArrayUsingSelector:@selector(compareWithNewsColumnSequence:)] mutableCopy];
    [self newsColumnButtonWillShowFromArray:self.newsColumnStoreButtons];
    
    
}


//先排序，在输出显示
-(void)newsColumnButtonWillShowFromArray:(NSArray<LJNewsColumnButton *> *) newsColumnButtons{
    
    int j = 0, k = 0, i = 0;
    
    for (LJNewsColumnButton *button in newsColumnButtons) {
        if (j == 4) {
            j = 0;
            k++;
        }
        button.newsColumn.columnSequence = i;
        [button setFrame:CGRectMake(OsideO + j*(BUTTONWIDTH + OsideO), 50 + k *(BUTTONHEIGHT+OsideO), BUTTONWIDTH, BUTTONHEIGHT)];
        i++;
        j++;
    }
    
}

//将未选择新闻栏目加入已选择新闻栏目
-(void)addNewsColumnFromStore:(LJNewsColumnButton *)sender{
    
    //已经加进来的新闻栏目，就不再需要点击事件了
    [sender removeTarget:self action:@selector(addNewsColumnFromStore:) forControlEvents:UIControlEventTouchUpInside];
    //还要加入拖动事件
    LJNCBGestureRecognizer *panGesture = [[LJNCBGestureRecognizer alloc] initWithTarget:self action:@selector(onpanButton:)];
    panGesture.delegate = self;
    panGesture.button = sender;
    [sender addGestureRecognizer:panGesture];
    
    sender.newsColumn.columnSelected = 1;
    sender.editSelected = 1;
    
    [self.newsColumnStoreButtons removeObject:sender];
    [sender removeFromSuperview];
    
    [self.newsColumnButtons addObject:sender];
    [self newsColumnButtonWillShowFromArray:self.newsColumnButtons];
    [self.allNewsColumnV addSubview:sender];
    
    [self newsColumnButtonWillShowFromArray:self.newsColumnStoreButtons];
}

//将已选择新闻栏目加入未选择新闻栏目
-(void)removeNewsColumnToStore:(UIButton *)smallButton{
    
    LJNewsColumnButton *sender = (LJNewsColumnButton *)smallButton.superview;
    
    //移出去的新闻栏目需要重新加入点击事件
    [sender addTarget:self action:@selector(addNewsColumnFromStore:) forControlEvents:UIControlEventTouchUpInside];
    //不需要拖动手势了
    [sender removeGestureRecognizer:sender.gestureRecognizers[0]];
     
    sender.newsColumn.columnSelected = 0;
    sender.editSelected = 0;
    
    [self.newsColumnButtons removeObject:sender];
    [sender removeFromSuperview];
    
    [self.newsColumnStoreButtons addObject:sender];
    [self newsColumnButtonWillShowFromArray:self.newsColumnStoreButtons];
    [self.newsColumnStoreV addSubview:sender];
    
    [self newsColumnButtonWillShowFromArray:self.newsColumnButtons];
    
}

//编辑按钮控制
-(void)onclickEdit:(UIButton *)sender{

    self.editSelected = !self.editSelected;
    
}

//按钮拖动手势执行函数
-(void)onpanButton:(LJNCBGestureRecognizer *)sender{
    
    static CGPoint btCenter ;
    static BOOL flag;
    
    //拖动开始执行
    if (sender.state == UIGestureRecognizerStateBegan) {
        btCenter = sender.button.center;
        LJNewsColumnButton *button = sender.button;
        [self.allNewsColumnV bringSubviewToFront:button];
        flag = NO;
    }
    
    //拖动过程中执行
    if (sender.state == UIGestureRecognizerStateChanged) {
        
        LJNewsColumnButton *button = sender.button;
        
        CGPoint center = button.center;
        CGPoint translation = [sender translationInView:self.view]; //拖动的坐标偏移
        
        button.center =CGPointMake(translation.x + center.x, translation.y + center.y) ;
        center = button.center;
        
        [button setNeedsDisplay];
        
        [sender setTranslation:CGPointZero inView:self.view]; //清空上次坐标偏移量
    }
    
    //拖动手势结束执行
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        LJNewsColumnButton *button = sender.button;
        
        CGPoint center = button.center;
        CGPoint translation = [sender translationInView:self.view]; //拖动的坐标偏移
        
        button.center =CGPointMake(translation.x + center.x, translation.y + center.y) ;
        center = button.center;
        
        //遍历数组，查看是拖到其他按钮里面，如果有，就将这个按钮插入到该位置，其他按钮后退以为
        for (LJNewsColumnButton *otherButton in self.newsColumnButtons) {
            
            if (button != otherButton && center.x >= otherButton.panPoint.beginX && center.x <= otherButton.panPoint.endX && center.y >= otherButton.panPoint.beginY && center.y <= otherButton.panPoint.endY) {
                
                NSInteger index = otherButton.newsColumn.columnSequence;
                
                [self.newsColumnButtons removeObject:button];
                [self.newsColumnButtons insertObject:button atIndex:index];
                [self newsColumnButtonWillShowFromArray:self.newsColumnButtons];
                
                //拖动成功
                flag = YES;
                break;
            }
        }
        
        //拖动不能成功，设置回原中心值
        if (!flag) {
            button.center  = btCenter;
        }
    }
    
}

//退出编辑新闻栏目
- (IBAction)exitController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
