//
//  ICHPersonAPIManager.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/4/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHPersonAPIManager.h"
#import "ICHBaseAPIManager.h"

@implementation ICHPersonAPIManager


+ (void)fetchPersonsWithPaginationPageId:(NSString *)pageID completionBlock:(void(^)(id object))completionBlock failureBlock:(void(^)(id object))failureBlock showIndicator:(BOOL)showIndicator
{
    NSDictionary *params = @{@"page": [NSString notNullString:pageID]};
    
    [ICHBaseAPIManager getRequestWithURLString:API_URL_SAMPLE_API withParameter:params withSuccess:^(id object) {
        
        completionBlock(object);
        
    } andFail:^(id errorObj) {
        
        failureBlock(errorObj);
        
    } showIndicator:showIndicator];
}


@end
