//
//  NewGroupViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "NewGroupViewController.h"
#import "GroupDAO.h"

@interface NewGroupViewController ()

@end

@implementation NewGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.group = [[Group alloc]init];
    self.group.gName = @"未命名";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)commitMeeting{
    BOOL insertGroupSuccess = NO;
    BOOL insertPeopleSuccess = YES;
    if (self.numberArr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未添加群组人员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([GroupDAO insertData:self.group]) {
        //NSLog(@"群组表增加成功");
        insertGroupSuccess = YES;
    }
    for (PersonNumber* person in self.numberArr) {
        person.pGroupId = [GroupDAO queryMaxId];
        if (![PersonNumberDAO insertData:person]) {
            insertPeopleSuccess = NO;
        }
    }
    if (insertGroupSuccess && insertPeopleSuccess) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存群组成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
    }
    
}
- (void)meetSetting{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入组名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *groupName = [alert textFieldAtIndex:0];
    groupName.placeholder = @"群组名";
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            self.group.gName = [alertView textFieldAtIndex:0].text;
//            NSLog(@"%@",[alertView textFieldAtIndex:0].text);
//            NSLog(@"%@",self.group.gName);
        }
    }
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}




#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   
    
}
*/

@end
