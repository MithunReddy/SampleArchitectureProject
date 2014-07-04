//
//  ICHPerson+Operations.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHPerson+Operations.h"

@implementation ICHPerson (Operations)

+ (ICHPerson *)personWithData:(NSDictionary *)data
{
    ICHPerson *person = [[ICHPerson alloc]init];
    [person updatePersonWithData:data];
    return person;
}


//Use this method if you want to just update existing object instead of creating new object
- (void)updatePersonWithData:(NSDictionary *)data
{
    self.personName  = [NSString notNullString: data[API_SAMPLE_API_DATA_KEY_NAME]];
    self.personAge = [NSString notNullString: data[API_SAMPLE_API_DATA_KEY_AGE]];
    self.personDescription  = [NSString notNullString: data[API_SAMPLE_API_DATA_KEY_DESCRIPTION]];
}

@end
