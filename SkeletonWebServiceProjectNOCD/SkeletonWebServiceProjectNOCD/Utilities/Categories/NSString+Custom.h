//
//  NSString+Custom.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Custom)
+ (NSString *)notNullString:(NSString *)string;
+ (NSString *)notNullAndWhiteSpaceTrimmedString:(NSString *)string;
+ (NSString *)notNullAndAllWhiteSpaceTrimmedString:(NSString *)string;

@end
