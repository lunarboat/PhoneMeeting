//
//  DateBaseUtil.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DateBaseUtil : NSObject

+(FMDatabase*)sharedDateBase;
+(void)moveDatebaseToSandBox;

@end
