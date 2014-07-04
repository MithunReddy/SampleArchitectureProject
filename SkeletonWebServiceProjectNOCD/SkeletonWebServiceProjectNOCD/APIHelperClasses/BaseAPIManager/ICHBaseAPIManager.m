//
//  ICHBaseAPIManager.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHBaseAPIManager.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"


@implementation ICHBaseAPIManager


#pragma mark - Request logging

+ (void)logDetailedRequest:(NSDictionary*)request
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request
                                                       options:0
                                                         error:nil];
    if (jsonData) {
        NSString *JSONString __attribute__((unused))  = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        debugLog(@" REQUEST \n %@ ",JSONString);
        
    }
}

#pragma mark - Post Request

+ (void) postRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)parameters withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock showIndicator:(BOOL)shouldShowIndicator
{
    
    if ([self isNetWorkAvailable])
    {
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
       
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        [manager.requestSerializer setValue:[NSString notNullString:@"sessionKey"] forHTTPHeaderField:@"authToken"];
        [manager.requestSerializer setValue:[NSString notNullString:@"userid"] forHTTPHeaderField:@"userID"];
            
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        if (shouldShowIndicator == YES)
        {
            [ICHActivityIndicator startAnimating];
        }
        
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            
             NSDictionary *result = (NSDictionary *)responseObject;
             
             successBlock(result);
             debugLog(@"error %@",responseObject);
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [ICHActivityIndicator stopAnimating];
             
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             debugLog(@"err %@",error);
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [ICHActivityIndicator stopAnimating];
             
             failBlock([error localizedDescription]);
             
         }];
    }
    else
    {
        failBlock(@"No Network");
        
    }
}


#pragma mark - Get Request

+ (void) getRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)parameters withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock  showIndicator:(BOOL)shouldShowIndicator
{
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([self isNetWorkAvailable])
    {
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
        
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        
        [manager.requestSerializer setValue:[NSString notNullString:@"sessionKey"] forHTTPHeaderField:@"authToken"];
        [manager.requestSerializer setValue:[NSString notNullString:@"userid"] forHTTPHeaderField:@"userID"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        if (shouldShowIndicator == YES)
        {
            [ICHActivityIndicator startAnimating];
        }
        
        [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             [ICHActivityIndicator stopAnimating];
             
             debugLog( @"Response %@ ",responseObject);
             
             if (successBlock)
             {
                 successBlock(responseObject);
             }
             
         }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             debugLog(@"err %@",error);
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [ICHActivityIndicator stopAnimating];
             if (failBlock)
             {
                 failBlock([error localizedDescription]);
             }
             
         }];
    }
    else
    {
        failBlock(@"No Network");
    }
}


#pragma mark - File Upload

+ (void) postRequestWithURLString:(NSString *)apiURL withFilePath:(NSURL *)filePathURL name:(NSString *)name withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock  showIndicator:(BOOL)shouldShowIndicator
{
    
    if ([self isNetWorkAvailable])
    {
        
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        
        if (shouldShowIndicator == YES)
        {
            [ICHActivityIndicator startAnimating];
        }
        
        [responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
        [manager setRequestSerializer:requestSerializer];
        [manager setResponseSerializer:responseSerializer];
        
        
        [manager.requestSerializer setValue:[NSString notNullString:@"sessionKey"] forHTTPHeaderField:@"authToken"];
        [manager.requestSerializer setValue:[NSString notNullString:@"userid"] forHTTPHeaderField:@"userID"];
        
        

        
        [manager POST:apiURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             [formData appendPartWithFileURL:filePathURL name:name fileName:[filePathURL lastPathComponent] mimeType:[ICHBaseAPIManager getMimeType:filePathURL] error:nil];
             debugLog(@"File name %@",[filePathURL lastPathComponent]);
         }
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [ICHActivityIndicator stopAnimating];
             debugLog(@"response %@",responseObject);
             
             successBlock(responseObject);
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [ICHActivityIndicator stopAnimating];
             failBlock(error.localizedDescription);
         }];
        
    }
    else
    {
        failBlock(@"No Network");
        
        
    }
}

+ (NSString *)getMimeType:(NSURL *)filePathURL
{
    NSString *mimeType = @"";
    if ([[filePathURL pathExtension] caseInsensitiveCompare:@"mp4"] == NSOrderedSame)
    {
        mimeType = @"video/mp4";
    }
    else if ([[filePathURL pathExtension] caseInsensitiveCompare:@"m4a"] == NSOrderedSame)
    {
        mimeType = @"audio/mp4a-latm";
    }
    else if ([[filePathURL pathExtension] caseInsensitiveCompare:@"jpg"] == NSOrderedSame)
    {
        mimeType = @"image/jpeg";
    }
    return mimeType;
}



#pragma mark - Network Error Handling

+ (BOOL)isNetWorkAvailable
{
    BOOL netWorkAvailable = NO;

    if ([[AFNetworkReachabilityManager sharedManager]isReachable])
    {
        netWorkAvailable = YES;
    }
    
    return netWorkAvailable;
}




@end
