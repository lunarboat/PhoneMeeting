//
//  AppointmentMeetingSetViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "AppointmentMeetingSetViewController.h"
#import "AppointmentViewController.h"

@interface AppointmentMeetingSetViewController ()

@end

@implementation AppointmentMeetingSetViewController{
    

    __weak IBOutlet UITextField *themeTextField;
    __weak IBOutlet UITextField *hostTextField;
    
    __weak IBOutlet UITextField *dateTextField;
    __weak IBOutlet UITextField *timeTextField;
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UIDatePicker *timerPicker;
    Meeting *meeting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    meeting = [[Meeting alloc]init];
    dateTextField.delegate = self;
    timeTextField.delegate = self;
    
    NSDate *date = [datePicker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateTextField.text = [formatter stringFromDate:date];
    [formatter setDateFormat:@"HH:mm"];
    timeTextField.text = [formatter stringFromDate:date];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 1:{
            dateTextField.enabled = NO;
            timeTextField.enabled = YES;
            [UIView animateWithDuration:0.5 animations:^{
                datePicker.frame = CGRectMake(385, 388, datePicker.bounds.size.width, datePicker.bounds.size.height);
                timerPicker.frame = CGRectMake(1024, timerPicker.frame.origin.y, timerPicker.bounds.size.width, timerPicker.bounds.size.height);
            } completion:^(BOOL finished) {
                
            }];
            
        
            break;
        }
        case 2:{
            dateTextField.enabled = YES;
            timeTextField.enabled = NO;
            [UIView animateWithDuration:0.5 animations:^{
                timerPicker.frame = CGRectMake(385, 388, timerPicker.bounds.size.width, timerPicker.bounds.size.height);
                datePicker.frame = CGRectMake(datePicker.frame.origin.y, 768 , datePicker.bounds.size.width, datePicker.bounds.size.height);
            } completion:^(BOOL finished) {
                
            }];
            
            
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dateChanged:(UIDatePicker *)sender {
    NSDate *date = [sender date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    dateTextField.text = [formatter stringFromDate:date];
    
}
- (IBAction)timeChanged:(UIDatePicker *)sender {
    NSDate *date = [sender date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    timeTextField.text = [formatter stringFromDate:date];
}


- (IBAction)commitClick:(id)sender {
    
    meeting.mTheme = themeTextField.text;
    meeting.mHost = hostTextField.text;
    meeting.mDate = dateTextField.text;
    meeting.mTime = timeTextField.text;
    if ([meeting.mTheme isEqualToString:@""]) {
        meeting.mTheme = @"无";
    }
    if ([meeting.mHost isEqualToString:@""]) {
        meeting.mHost = @"无";
    }
//    AppointmentViewController *apoVc = (AppointmentViewController*)self.presentingViewController;
//    apoVc.meeting = meeting;
//    NSLog(@"%d,%@",((UINavigationController*)self.presentingViewController).viewControllers.count,self.presentedViewController);
    UINavigationController *nav = (UINavigationController*)self.presentingViewController;
    AppointmentViewController *apVc = [nav.viewControllers lastObject];
    apVc.meet = meeting;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
