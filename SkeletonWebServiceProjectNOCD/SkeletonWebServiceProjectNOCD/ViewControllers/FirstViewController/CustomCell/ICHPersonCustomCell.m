//
//  ICHPersonCustomCell.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/5/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHPersonCustomCell.h"

@implementation ICHPersonCustomCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutNibItems
{
    self.nameLabel.text = self.person.personName;
    self.ageLabel.text = self.person.personAge;
    self.descriptionLabel.text = self.person.personDescription;

}

@end
