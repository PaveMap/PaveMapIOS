//
//  iCoreGUIController.h
//  PaveMap
//
//  Created by Tung Nguyen on 10/5/14.
//  Copyright (c) 2014 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface iCoreGUIController : NSObject{
    UINavigationController *navi;
}


@property (nonatomic, strong) FBSession *fbSession;
@property (nonatomic, strong) UIWindow *window;


+ (id)sharedCoreGUI;

-(void)startUp;
- (void)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
                     withController:(NSString *)nameController
                       withComplete:(void (^)(int state))complete;

@end
