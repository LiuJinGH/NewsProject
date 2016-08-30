//
//  LJNewsColumnStore.h
//  LJTouTiaoNewsDemo
//
//  Created by 刘瑾 on 16/8/10.
//  Copyright © 2016年 刘瑾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NewsColumn;
@interface LJNewsColumnStore : NSObject

@property (nonatomic, readonly) NSArray *allNewsColumns;
@property (nonatomic, readonly) NSArray *newsColumnsStore;

+(instancetype) sharedInstanceBySingleton;

-(void)addNewsColumns:(NewsColumn *)colum;
-(void)removeNewsCoumns:(NewsColumn *)colum;

@end
