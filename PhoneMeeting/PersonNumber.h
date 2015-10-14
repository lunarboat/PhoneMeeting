//
//  PersonNumber.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/29.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonNumber : NSObject

@property (nonatomic,assign) int pId;
@property (nonatomic,retain) NSString *pNumber;
@property (nonatomic,retain) NSString *pName;
@property (nonatomic,assign) int pMeetingId;
@property (nonatomic,assign) int pGroupId;

@end
