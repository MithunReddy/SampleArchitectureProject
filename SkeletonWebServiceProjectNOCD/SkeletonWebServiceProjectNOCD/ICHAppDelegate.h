//
//  ICHAppDelegate.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 6/27/14.
//  Copyright (c) 2014 idev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKRevealController;

@interface ICHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) PKRevealController *revealController;
@end
