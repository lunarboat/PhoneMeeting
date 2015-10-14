//
//  NewGroupViewController.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "ImmediateMeetingViewController.h"
#import "Group.h"

@interface NewGroupViewController : ImmediateMeetingViewController<UIAlertViewDelegate>

@property(nonatomic,retain) Group *group;

@end
