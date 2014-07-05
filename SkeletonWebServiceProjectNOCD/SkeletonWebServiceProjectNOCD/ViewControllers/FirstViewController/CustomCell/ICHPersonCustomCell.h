//
//  ICHPersonCustomCell.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/5/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICHPerson.h"

@interface ICHPersonCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) ICHPerson *person;

-(void)layoutNibItems;

@end
