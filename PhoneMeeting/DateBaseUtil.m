//
//  DateBaseUtil.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "DateBaseUtil.h"

@implementation DateBaseUtil

+(FMDatabase*)sharedDateBase{
    FMDatabase *db = nil;
    if (!db) {
        db = [[FMDatabase alloc]initWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/phoneMeeting.sqlite"]];
        }
    return db;
}

//第一次把数据库从项目中拷贝到沙盒中
+(void)moveDatebaseToSandBox{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"phoneMeeting" ofType:@"sqlite"];
    NSString *toPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/phoneMeeting.sqlite"];
    //NSLog(@"%@",toPath);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error = nil;
    if (![manager fileExistsAtPath:toPath]) {
        [manager copyItemAtPath:path toPath:toPath error:&error];
    }
}

@end
