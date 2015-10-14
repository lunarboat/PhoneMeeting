//
//  GroupCellViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "GroupCellViewController.h"
#import "GroupDAO.h"

@interface GroupCellViewController ()

@end

@implementation GroupCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"group:%@",self.group);
    self.numberArr = [PersonNumberDAO queryPeopleWithGroupId:self.group.gId];
    
    
    
    self.theNewGroup = [[Group alloc]init];
    self.theNewGroup.gId = self.group.gId;
    self.theNewGroup.gName = self.group.gName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commitMeeting{
    BOOL clearGroupSuccess = NO;
    BOOL updateGroupSuccess = NO;
    BOOL updatePeopleSuccess = YES;
//    if ([GroupDAO updateGroup:self.theNewGroup]) {
//        updateGroupSuccess = YES;
//    }
    updateGroupSuccess = [GroupDAO updateGroup:self.theNewGroup];
    clearGroupSuccess = [PersonNumberDAO deletePeopleWithGroupId:self.group.gId];
    for (PersonNumber* person in self.numberArr) {
        person.pGroupId = self.theNewGroup.gId;
        if (![PersonNumberDAO insertData:person]) {
            updatePeopleSuccess = NO;
        }
    }
    if (clearGroupSuccess && updateGroupSuccess &&updatePeopleSuccess) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存群组成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
}
-(void)meetSetting{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入新组名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *groupName = [alert textFieldAtIndex:0];
    groupName.placeholder = @"新群组名";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            self.theNewGroup.gName = [alertView textFieldAtIndex:0].text;
                       // NSLog(@"%@",[alertView textFieldAtIndex:0].text);
                      // NSLog(@"%@",self.theNewGroup.gName);
        }
    }
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ToImmediateMeeting"]) {
        id vc = segue.destinationViewController;
        [vc setValue:self.numberArr forKey:@"numberArr"];
    }
    if ([segue.identifier isEqualToString:@"ToAppointment"]) {
        id vc = segue.destinationViewController;
        [vc setValue:self.numberArr forKey:@"numberArr"];
    }
}


@end
