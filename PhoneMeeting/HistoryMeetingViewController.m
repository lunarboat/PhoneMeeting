//
//  HistoryMeetingViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "HistoryMeetingViewController.h"
#import "MeetingDAO.h"

@interface HistoryMeetingViewController ()

@end

@implementation HistoryMeetingViewController{
    
    __weak IBOutlet UISearchBar *_searchBar;
    __weak IBOutlet UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.meetArr = [MeetingDAO queryMeeting];
   // NSLog(@"%d",[MeetingDAO queryMeeting].count);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _meetArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellMeeting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    Meeting *meet = [_meetArr objectAtIndex:indexPath.row];
    cell.textLabel.text = meet.mTheme;
    cell.detailTextLabel.text = meet.mDate;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Meeting *meet = [_meetArr objectAtIndex:indexPath.row];
    if ([MeetingDAO deleteMeeting:meet]) {
        [_meetArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (IBAction)editClick:(id)sender {
    [_tableView setEditing:!_tableView.isEditing];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBckClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
