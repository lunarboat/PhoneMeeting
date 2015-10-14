//
//  AppointmentViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "AppointmentViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)commitMeeting{
    if (self.meet) {
        BOOL insertMeetSuccess = NO;
        BOOL insertPeopleSuccess = YES;
        if (self.numberArr.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未添加参会人员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else if ([MeetingDAO insertData:self.meet]) {
            NSLog(@"会议表增加成功");
            insertMeetSuccess = YES;
        }
        for (PersonNumber* person in self.numberArr) {
            person.pMeetingId = [MeetingDAO queryMaxId];
            if (![PersonNumberDAO insertData:person]) {
                insertPeopleSuccess = NO;
            }
        }
        if (insertMeetSuccess && insertPeopleSuccess) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"会议预约成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 2;
            [alert show];
        }
    }else{
        NSLog(@"nil");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
