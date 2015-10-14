//
//  HistoryMeetingViewController.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryMeetingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property(nonatomic,retain)NSMutableArray *meetArr;

@end
