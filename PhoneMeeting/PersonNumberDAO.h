//
//  PersonNumberDAO.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateBaseUtil.h"
#import "PersonNumber.h"

@interface PersonNumberDAO : NSObject

+(BOOL)insertData:(PersonNumber*)person;
+(BOOL)deletePeopleWithGroupId:(int)groupId;
+(NSMutableArray*)queryPeopleWithGroupId:(int)groupId;
@end
