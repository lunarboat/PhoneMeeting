//
//  GroupCellViewController.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "ImmediateMeetingViewController.h"
#import "Group.h"
#import "PersonNumberDAO.h"

@interface GroupCellViewController : ImmediateMeetingViewController

@property (nonatomic,retain) Group *group;
@property (nonatomic,retain) Group *theNewGroup;

@end
