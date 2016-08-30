//
//  LJNewsColumnStore.m
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import "LJNewsColumnStore.h"
#import "LJNewsColumn.h"

@class LJNewsColumn;

@interface LJNewsColumnStore ()

@property (nonatomic) NSMutableArray<LJNewsColumn *> *privateNewsColumns;
@property (nonatomic) NSMutableArray<LJNewsColumn *> *privateNewsColumnsStore;

@end

@implementation LJNewsColumnStore

#pragma mark -- LJNewsColumnStrore 存取方法

-(NSArray *)allNewsColumns{
    return self.privateNewsColumns;
}

-(NSArray *)newsColumnsStore{
    return self.privateNewsColumnsStore;
}

-(NSMutableArray *)privateNewsColumns{
    if (!_privateNewsColumns) {
        _privateNewsColumns = [[NSMutableArray alloc] init];
    }
    return _privateNewsColumns;
}

-(NSMutableArray<LJNewsColumn *> *)privateNewsColumnsStore{
    if (!_privateNewsColumnsStore) {
        _privateNewsColumnsStore = [[NSMutableArray alloc] init];
    }
    return _privateNewsColumnsStore;
}


#pragma mark -- LJNewsColumnStrore 初始化方法

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singlton Error" reason:@"please use method sharedInstanceBySingleton" userInfo:nil];
}

+(instancetype)sharedInstanceBySingleton{
    static LJNewsColumnStore *ncs = nil;
    if (!ncs) {
        ncs = [[LJNewsColumnStore alloc] initPrivate];
    }
    return ncs;
}

-(instancetype) initPrivate{
    if (self = [super init]) {
        [self getPlistDataToStore];
    }
    return self;
}

#pragma mark -- LJNewsColumnStrore 获取数据方法

-(void)addNewsColumns:(NewsColumn *)colum{
    
}
-(void)removeNewsCoumns:(NewsColumn *)colum{
    
}

-(void) getPlistDataToStore{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"NewsColumStore" ofType:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *newsColumnDic in plistArray) {
        //KVC
        //字典把所有的key逐个取出，然后用每个key的名字和对象的属性名字进行匹配，如果key和属性名称一样，就把value取出给该属性赋值
        LJNewsColumn *newsColumn = [[LJNewsColumn alloc] init];
        
        [newsColumn setValuesForKeysWithDictionary:newsColumnDic];
        //        NSLog(@"newsColumn name is %@",newsColumn.columnName);
        
        if (newsColumn.columnSelected) {
            [self.privateNewsColumns addObject:newsColumn];
        }else{
            [self.privateNewsColumnsStore addObject:newsColumn];
        }
    }
    
}
@end
