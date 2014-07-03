//
//  NSString+Custom.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "NSString+Custom.h"

@implementation NSString (Custom)


+ (NSString *)notNullString:(NSString *)string
{
    if (string == (id)[NSNull null] || string == nil || string == NULL)
    {
        return @"";
    }
    
    return string;
    
    
}

+ (NSString *)notNullAndWhiteSpaceTrimmedString:(NSString *)string
{
    if (string == (id)[NSNull null] || string == nil || string == NULL)
    {
        return @"";
    }
    
    return [string stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
    
}

+ (NSString *)notNullAndAllWhiteSpaceTrimmedString:(NSString *)string
{
    if (string == (id)[NSNull null] || string == nil || string == NULL)
    {
        return @"";
    }
    
    return [[string stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceCharacterSet]]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}


@end
