//
//  ImmediateMeetingViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "ImmediateMeetingViewController.h"


@interface ImmediateMeetingViewController ()

@end

@implementation ImmediateMeetingViewController{
    
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *_viewWithTextField;
    
    __weak IBOutlet UITextField *_textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.meet = [[Meeting alloc]init];
    self.meet.mHost = @"无";
    self.meet.mTheme = @"无";
    
    if (self.numberArr == nil) {
        _numberArr = [[NSMutableArray alloc]init];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextFieldFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)meetingClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            [self commitMeeting];
            break;
        case 11:
            [self meetSetting];
            break;
        case 12:
            [self numberSetting];
            break;
        case 13:
            [self selectWithContact];
            break;
        case 14:
            [self help];
            break;
            
        default:
            break;
    }
    
    
}
- (IBAction)inputClick:(id)sender {
    if ([self isMobileNumber:_textField.text]) {
        PersonNumber *person = [[PersonNumber alloc]init];
        person.pName = @"匿名";
        person.pNumber = _textField.text;
        [_numberArr addObject:person];
        [_tableView reloadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"非正确号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _numberArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellPhoneNumber";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    PersonNumber *person = [_numberArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",person.pName,person.pNumber];
    return cell;
}

-(void)changeTextFieldFrame:(NSNotification *)notice{
    //NSLog(@"userinfo:%@",notice.userInfo);
    double time = [[notice.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [[notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    int curve = [[notice.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]intValue];;
    
   [UIView animateWithDuration:time animations:^{
       _viewWithTextField.frame = CGRectMake(rect.origin.x, rect.origin.y-_viewWithTextField.bounds.size.height, _viewWithTextField.bounds.size.width, _viewWithTextField.bounds.size.height);
       [UIView setAnimationCurve:curve];
   } completion:^(BOOL finished) {
       
   }];
}

#pragma mark operationForMeeting
-(void)commitMeeting{
    BOOL insertMeetSuccess = NO;
    BOOL insertPeopleSuccess = YES;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.meet.mDate = [formatter stringFromDate:date];
    [formatter setDateFormat:@"HH:mm:ss"];
    self.meet.mTime = [formatter stringFromDate:date];
    if (_numberArr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未添加参会人员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if ([MeetingDAO insertData:self.meet]) {
        NSLog(@"会议表增加成功");
        insertMeetSuccess = YES;
    }
    
    for (PersonNumber* person in _numberArr) {
        person.pMeetingId = [MeetingDAO queryMaxId];
        if (![PersonNumberDAO insertData:person]) {
            insertPeopleSuccess = NO;
        }
    }
    if (insertMeetSuccess && insertPeopleSuccess) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"即时会议发出成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
    }
    
}

-(void)meetSetting{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入会议主题和主持人号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *theme = [alert textFieldAtIndex:0];
    UITextField *host = [alert textFieldAtIndex:1];
    theme.placeholder = @"会议主题";
    host.placeholder = @"主持人号";
    host.secureTextEntry = NO;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            if (![[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
                self.meet.mTheme = [alertView textFieldAtIndex:0].text;
            }
            if (![[alertView textFieldAtIndex:1].text isEqualToString:@""]) {
                self.meet.mHost = [alertView textFieldAtIndex:1].text;
            }
            
            
        }
    }
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

-(void)numberSetting{
    [_tableView setEditing:!_tableView.isEditing];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_numberArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    //NSLog(@"_numberArr Count:%d",_numberArr.count);
}

-(void)selectWithContact{
    ABPeoplePickerNavigationController *abNc = [[ABPeoplePickerNavigationController alloc]init];
    abNc.peoplePickerDelegate = self;
    [self presentViewController:abNc animated:YES completion:nil];
}

-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    NSMutableArray *phones = [[NSMutableArray alloc]init];
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    //    ABMutableMultiValueRef address=ABRecordCopyValue(person, kABPersonAddressProperty);
    //    ABMutableMultiValueRef birthday=ABRecordCopyValue(person, kABPersonBirthdayProperty);
    //    ABMutableMultiValueRef creationDate=ABRecordCopyValue(person, kABPersonCreationDateProperty);
    //    ABMutableMultiValueRef date=ABRecordCopyValue(person, kABPersonDateProperty);
    //    ABMutableMultiValueRef department=ABRecordCopyValue(person, kABPersonDepartmentProperty);
    //    ABMutableMultiValueRef email=ABRecordCopyValue(person, kABPersonEmailProperty);
    //    ABMutableMultiValueRef firstNamePhonetic=ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
    NSString* firstName=(__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    //    ABMutableMultiValueRef instantMessage=ABRecordCopyValue(person, kABPersonInstantMessageProperty);
    //    ABMutableMultiValueRef jobTitle=ABRecordCopyValue(person, kABPersonJobTitleProperty);
    //    ABMutableMultiValueRef kind=ABRecordCopyValue(person, kABPersonKindProperty);
    //    ABMutableMultiValueRef lastNamePhonetic=ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
    NSString * lastName=(__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    //    ABMutableMultiValueRef middleNamePhonetic=ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
    //    ABMutableMultiValueRef middleName=ABRecordCopyValue(person, kABPersonMiddleNameProperty);
    //    ABMutableMultiValueRef modificationDate=ABRecordCopyValue(person, kABPersonModificationDateProperty);
    //    ABMutableMultiValueRef nickname=ABRecordCopyValue(person, kABPersonNicknameProperty);
    //    ABMutableMultiValueRef note=ABRecordCopyValue(person, kABPersonNoteProperty);
    //    ABMutableMultiValueRef organization=ABRecordCopyValue(person, kABPersonOrganizationProperty);
    //    ABMutableMultiValueRef phone=ABRecordCopyValue(person, kABPersonPhoneProperty);
    //    ABMutableMultiValueRef prefix=ABRecordCopyValue(person, kABPersonPrefixProperty);
    //    ABMutableMultiValueRef relatedNames=ABRecordCopyValue(person, kABPersonRelatedNamesProperty);
    //    ABMutableMultiValueRef socialProfile=ABRecordCopyValue(person, kABPersonSocialProfileProperty);
    //    ABMutableMultiValueRef personSuffix=ABRecordCopyValue(person, kABPersonSuffixProperty);
    //    ABMutableMultiValueRef _URL=ABRecordCopyValue(person, kABPersonURLProperty);
    for (int i=0 ; i<ABMultiValueGetCount(phoneMulti) ; i++) {
        NSString *phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i);
        [phones addObject:phone];
    }
    PersonNumber *p = [[PersonNumber alloc]init];
    p.pName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
    p.pNumber = [phones lastObject];
    [_numberArr addObject:p];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_tableView reloadData];
}
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)help{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//UIKeyboardAnimationCurveUserInfoKey = 7;
//UIKeyboardAnimationDurationUserInfoKey = "0.25";
//UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {1024, 391}}";
//UIKeyboardCenterBeginUserInfoKey = "NSPoint: {512, 963.5}";
//UIKeyboardCenterEndUserInfoKey = "NSPoint: {512, 572.5}";
//UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 768}, {1024, 391}}";
//UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 377}, {1024, 391}}";


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
