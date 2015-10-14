//
//  UserRegisterViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/29.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "UserRegisterViewController.h"

@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController{
    
    __weak IBOutlet UIImageView *backgroundImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBack:(id)sender {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:backgroundImageView cache:YES];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
    
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
