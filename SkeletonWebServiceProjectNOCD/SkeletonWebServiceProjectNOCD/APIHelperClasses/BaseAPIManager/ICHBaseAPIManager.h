//
//  ICHBaseAPIManager.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICHBaseAPIManager : NSObject
+ (void) postRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)dict withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock ;

+ (void) postRequestWithURLString:(NSString *)apiURL withFilePath:(NSURL *)filePathURL withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock;
+ (void) getRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)dict withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock needToShowIndicator:(BOOL)showIndicator needToCache:(BOOL)shouldCache;

+ (NSString *)baseURL;
+ (BOOL)isNetWorkAvailable;

@end
