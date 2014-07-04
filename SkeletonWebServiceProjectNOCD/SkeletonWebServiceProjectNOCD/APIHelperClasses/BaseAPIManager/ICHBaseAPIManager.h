//
//  ICHBaseAPIManager.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICHBaseAPIManager : NSObject
+ (void) postRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)parameters withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock showIndicator:(BOOL)shouldShowIndicator;

+ (void) getRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)parameters withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock  showIndicator:(BOOL)shouldShowIndicator;

//For file upload
+ (void) postRequestWithURLString:(NSString *)apiURL withFilePath:(NSURL *)filePathURL name:(NSString *)name withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock  showIndicator:(BOOL)shouldShowIndicator;

+ (BOOL)isNetWorkAvailable;

@end
