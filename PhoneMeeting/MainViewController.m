//
//  MainViewController.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/29.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "MainViewController.h"
#import "UserRegisterViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    
    
    __weak IBOutlet UIImageView *bg42ImageView;
    
    __weak IBOutlet UIButton *userSettingBtn;
    
    __weak IBOutlet UIButton *logoBackBtn;
    __weak IBOutlet UIImageView *biaotopImageView;
    __weak IBOutlet UIView *userSettingView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    [self performSelector:@selector(showAnimation) withObject:nil afterDelay:.1];
}

-(void)showAnimation{
    [UIView animateWithDuration:1 animations:^{
//        logoButton.frame = CGRectMake(349, 70/324, 326, 120);
        logoBackBtn.frame = CGRectMake(349, 70, 326, 120);
        bg42ImageView.frame = CGRectMake(0, 0, 1024, 329);
        //236
        userSettingBtn.frame = CGRectMake(440, 236, 150, 200);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)userSettingClick:(UIButton *)sender {
    
    
//    [UIView animateWithDuration:1 animations:^{
//        
//        bg42ImageView.frame = CGRectMake(0, -436, 1024, 329);
//        //236
//        userSettingBtn.frame = CGRectMake(440, -200, 150, 200);
//        logoBackBtn.frame = CGRectMake(0, 0, 163, 60);
//        biaotopImageView.frame = CGRectMake(0, 0, 1024, 60);
//        userSettingView.frame = CGRectMake(160, 100, 700, 400);
//        
//    }];
    [UIView animateWithDuration:1 animations:^{
        bg42ImageView.frame = CGRectMake(0, -436, 1024, 329);
        //236
        userSettingBtn.frame = CGRectMake(440, -200, 150, 200);
        logoBackBtn.frame = CGRectMake(0, 0, 163, 60);
        biaotopImageView.frame = CGRectMake(0, 0, 1024, 60);
        userSettingView.frame = CGRectMake(160, 100, 700, 400);
    } completion:^(BOOL finished) {
        //[self performSegueWithIdentifier:@"ToUserSetting" sender:self];
    }];
    
    
    
}




- (IBAction)logoBackClick:(UIButton *)sender {
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        logoBackBtn.frame = CGRectMake(349, 70, 326, 120);
        bg42ImageView.frame = CGRectMake(0, 0, 1024, 329);
        //236
        userSettingBtn.frame = CGRectMake(440, 236, 150, 200);
        userSettingView.frame = CGRectMake(160, 1424, 700, 400);
    } completion:^(BOOL finished){
        userSettingView.frame = CGRectMake(160, -400, 700, 400);
    }];
    
}

- (IBAction)bigViewBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            
            break;
        case 11:
            
            break;
        case 12:
            
            break;
        case 13:
            
            break;
            
        case 14:
            
            break;
            
        default:
            break;
    }
}

- (IBAction)smallViewBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionTransitionFlipFromRight) animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:userSettingView cache:YES];
    } completion:^(BOOL finished) {
        
        switch (sender.tag) {
            case 20:
                [self performSegueWithIdentifier:@"toRegister" sender:self];
                break;
            
            case 21:
                
                break;
            case 22:
                
                break;
                
            default:
                break;
        }
        
        
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
