//
//  ICHPersonFetcher.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/4/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICHPersonFetcher : NSObject

+ (void)fetchPersonsWithPageID:(NSString *)pageID withCompletionBlock:(void(^)(NSArray * personArray))completionBlock failureBlock:(void(^)(id object))failureBlock showIndicator:(BOOL)showIndicator;

@end
