//
//  iCoreGUIController.m
//  PaveMap
//
//  Created by Tung Nguyen on 10/5/14.
//  Copyright (c) 2014 Tung Nguyen. All rights reserved.
//

#import "iCoreGUIController.h"

#import "LoginViewController.h"

@interface iCoreGUIController ()

@property (nonatomic, strong) FBSession *loggedInSession;

@end

@implementation iCoreGUIController
@synthesize window, fbSession;

+ (id)sharedCoreGUI {
    static iCoreGUIController *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)startUp{
    [FBProfilePictureView class];
    
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    navi = [[UINavigationController alloc]init];
    [navi pushViewController:login animated:YES];
    [window setRootViewController:navi];
}

- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
                     withController:(NSString *)nameController
                       withComplete:(void (^)(int state))complete{
    
    if (!allowLoginUI || fbSession.isOpen) {
        [fbSession closeAndClearTokenInformation];
    } else {
        if (fbSession.state != FBSessionStateCreated || fbSession == nil) {
            fbSession = [[FBSession alloc] init];
        }
        [fbSession openWithCompletionHandler:^(FBSession *session,
                                               FBSessionState status,
                                               NSError *error) {
            [self sessionStateChanged:session
                                state:status
                                error:error
                             withName:nameController
                         withComplete:complete];
        }];
    }
}

/*
 *
 */
- (void) closeSession {
    [fbSession closeAndClearTokenInformation];
    //    [fbSession release];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
                   withName:(NSString *)name
               withComplete:(void (^)(int state))complete
{
    if (error) {
        NSLog(@"error = %@", error);
    }
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                //NSLog(@"User session found");
                [FBSession setActiveSession:session];
                //                [self getUserDetailFromFB];
                
                [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    
                    if (!error) {
                        //                        self.loggedInUserID = user.id;
                        self.loggedInSession = FBSession.activeSession;
                        if ([name isEqualToString:@"Login"]) {
//                            [self callback:result];
                            NSLog(@"result = %@", result);
                        }else {
                            if (complete) {
                                complete(1);
                            }
                        }
                        
                    }else{
                        if ([name isEqualToString:@"Login"]) {
                            NSLog(@"login error");
                        }else {
                            if (complete) {
                                complete(2);
                            }
                        }
                    }
                }];
            }
            break;
        case FBSessionStateClosed:
            if ([name isEqualToString:@"Login"]) {
                NSLog(@"FBSessionStateClosed");
            }else {
                if (complete) {
                    complete(3);
                }
            }
            break;
            
        case FBSessionStateClosedLoginFailed:
            if ([name isEqualToString:@"Login"]) {
                NSLog(@"FBSessionStateClosedLoginFailed");
            }else {
                if (complete) {
                    complete(4);
                }
            }
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
}


@end
