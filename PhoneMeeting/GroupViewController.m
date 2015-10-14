//
//  GroupViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/31.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupDAO.h"
#import "PersonNumberDAO.h"

@interface GroupViewController ()

@end

@implementation GroupViewController{
    
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *_groupArr;
    Group *selectedGroup;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _groupArr = [[NSMutableArray alloc]init];
}
- (void)viewWillAppear:(BOOL)animated{
    _groupArr = [GroupDAO queryGroup];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewOperation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _groupArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"groupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    Group *group = [_groupArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d:%@",group.gId,group.gName];
    return cell;
}


- (IBAction)newGroupClick:(id)sender {
}
- (IBAction)settingGroupClick:(id)sender {
    [_tableView setEditing:!_tableView.isEditing];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Group *group = [_groupArr objectAtIndex:indexPath.row];
    if ([GroupDAO deleteGroup:group]&&[PersonNumberDAO deletePeopleWithGroupId:group.gId]) {
        //NSLog(@"数据库表已删除");
    }
    [_groupArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
- (IBAction)helpClick:(id)sender {
}
- (IBAction)goBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedGroup = [_groupArr objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ToSelectedGroup" sender:self];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ToSelectedGroup"]) {
        id vc = segue.destinationViewController;
        [vc setValue:selectedGroup forKey:@"group"];
    }
}


@end
