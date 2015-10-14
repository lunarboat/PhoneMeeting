//
//  GroupDAO.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateBaseUtil.h"
#import "Group.h"

@interface GroupDAO : NSObject

+(int)queryMaxId;
+(BOOL)insertData:(Group*)group;
+(NSMutableArray*)queryGroup;
+(BOOL)deleteGroup:(Group*)group;
+(BOOL)updateGroup:(Group*)group;
@end
