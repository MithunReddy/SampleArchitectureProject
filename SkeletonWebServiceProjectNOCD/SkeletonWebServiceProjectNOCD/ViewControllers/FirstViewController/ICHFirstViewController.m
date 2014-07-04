//
//  ICHFirstViewController.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 6/27/14.
//  Copyright (c) 2014 idev. All rights reserved.
//

#import "ICHFirstViewController.h"
#import "ICHPersonFetcher.h"
#import "ICHPerson.h"
#import "ICHObjectPrinter.h"

@interface ICHFirstViewController ()

@end

@implementation ICHFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTapped:(id)sender {
    
//    [ICHAlertView showAlertWithTiTle:@"Title" message:@"DFDSFSDF" cancelButtonTitle:@"CANCEL" otherButtonTitles:@[@"Ok"] withCompletionBlock:^(NSInteger index) {
//        
//        debugLog(@"alert index %ld",(long)index);
//        
//    } andCancelBlock:^{
//        
//        debugLog(@"alert cancel");
//        
//    } ];
    
    [ICHPersonFetcher fetchPersonsWithPageID:@"2" withCompletionBlock:^(NSArray *personArray) {
        for (ICHPerson *person in personArray)
        {
            debugLog(@"\nperson obj %@",[ICHObjectPrinter descriptionForObject:person]);

        }
        
    } failureBlock:^(id object) {
        
    } showIndicator:YES];
}

@end
