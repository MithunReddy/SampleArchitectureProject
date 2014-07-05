//
//  ICHFirstViewController.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 6/27/14.
//  Copyright (c) 2014 idev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICHFirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sampleTableView;
@property (weak, nonatomic) IBOutlet UITableView *personTableView;


@end
