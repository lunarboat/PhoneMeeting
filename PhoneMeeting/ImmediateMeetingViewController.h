//
//  ImmediateMeetingViewController.h
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Meeting.h"
#import "PersonNumber.h"
#import "PersonNumberDAO.h"
#import "MeetingDAO.h"

@interface ImmediateMeetingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ABPeoplePickerNavigationControllerDelegate>{
    
}
@property (nonatomic,retain) NSMutableArray *numberArr;
@property (nonatomic,retain) Meeting *meet;

-(void)commitMeeting;
-(void)meetSetting;
@end
