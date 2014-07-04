//
//  ICHPersonAPIManager.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/4/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICHPersonAPIManager : NSObject
+ (void)fetchPersonsWithPaginationPageId:(NSString *)pageID completionBlock:(void(^)(id object))completionBlock failureBlock:(void(^)(id object))failureBlock showIndicator:(BOOL)showIndicator;

@end
