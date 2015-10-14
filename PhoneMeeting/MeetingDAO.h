//
//  MeetingDAO.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateBaseUtil.h"
#import "Meeting.h"

@interface MeetingDAO : NSObject

+(BOOL)insertData:(Meeting*)meet;
+(int)queryMaxId;
+(NSMutableArray*)queryMeeting;
+(BOOL)deleteMeeting:(Meeting*)meet;
@end
