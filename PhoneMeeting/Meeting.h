//
//  Meeting.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/29.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meeting : NSObject

@property (nonatomic,assign) int mId;
@property (nonatomic,retain) NSString *mTheme;
@property (nonatomic,retain) NSString *mHost;
@property (nonatomic,retain) NSString *mDate;
@property (nonatomic,retain) NSString *mTime;


@end
