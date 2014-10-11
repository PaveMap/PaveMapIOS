//
//  LoginViewController.m
//  PaveMap
//
//  Created by Tung Nguyen on 10/5/14.
//  Copyright (c) 2014 Tung Nguyen. All rights reserved.
//

#import "LoginViewController.h"
#import "iCoreGUIController.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UIButton *btnLogin;
@property (nonatomic, weak) IBOutlet UILabel *lblTest;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.btnLogin addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnPressed:(id)sender{
    if (sender == self.btnLogin) {
        NSLog(@"login");
        iCoreGUIController *core = [iCoreGUIController sharedCoreGUI];
        [core openSessionWithAllowLoginUI:YES withController:@"Login" withComplete:^(int state) {
            NSLog(@"state = %d", state);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
