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
+(NSString *)baseURL {
    return BASE_API_URL;
}

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
            [ICHActivityIndicator startAnimating:YES];
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



//+ (void) getRequestWithURLString:(NSString *)urlString withParameter:(NSDictionary *)dict withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock needToShowIndicator:(BOOL)showIndicator needToCache:(BOOL)shouldCache
//{
//    
//    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    if ([self isNetWorkAvailable])
//    {
//        
//        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:BASE_API_URL]];
//        
//        NSMutableDictionary *inputDataWithSessionId = [[NSMutableDictionary alloc] initWithDictionary:dict];
//        
//        
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        FUUser *user = [FUUser currentLoggedInUser];
//        FUUser *tempUser = [FUUser getTempUser];
//        
//        if(user)
//        {
//            [manager.requestSerializer setValue:[NSString notNullString:user.apiUserToken] forHTTPHeaderField:@"authToken"];
//            [manager.requestSerializer setValue:[NSString notNullString:user.userID] forHTTPHeaderField:@"userID"];
//            NSArray *shareIDs = [FUSharingManager getShareIDsFromUserDefaults];
//            
//            if(nil != shareIDs && shareIDs.count > 0)
//            {
//                
//                NSString * shareIDsString = [shareIDs componentsJoinedByString:@","];
//                [manager.requestSerializer setValue:[NSString notNullString:shareIDsString] forHTTPHeaderField:@"sid"];
//            }
//        }
//        else if(tempUser)
//        {
//            [manager.requestSerializer setValue:[NSString notNullString:tempUser.apiUserToken] forHTTPHeaderField:@"authToken"];
//            [manager.requestSerializer setValue:[NSString notNullString:tempUser.userID] forHTTPHeaderField:@"userID"];
//            
//        }
//        
//        //        [self logDetailedRequest:inputDataWithSessionId];
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        
//        [FUActivityIndicator startAnimating:showIndicator];
//        debugLog(@"getURL params %@",dict);
//        
//        debugLog(@"getURL %@%@",BASE_API_URL,urlString);
//        
//        
//        [manager GET:urlString parameters:inputDataWithSessionId success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             if([FUUtility isUserSignedIn])
//             {
//                 [FUSharingManager clearAllShareIDs];
//             }
//             //             NSDictionary *result = (NSDictionary *)responseObject;
//             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//             
//             // set unread message count for logged in user
//             NSDictionary *responseDictionary = (NSDictionary *)responseObject;
//             NSNumber *statusCode = [responseDictionary objectForKey:API_RESPONSE_ERROR_KEY];
//             
//             if ( [statusCode isEqualToNumber:[NSNumber numberWithInteger:API_SUCCESS_CODE]])
//             {
//                 FUUser *user = [FUUser currentLoggedInUser];
//                 NSDictionary *dataDictionay = [responseDictionary objectForKey:API_DATA_FIELD_KEY];
//                 
//                 
//                 if (user)
//                 {
//                     FUAppDelegate *appdelegate = (FUAppDelegate *)[UIApplication sharedApplication].delegate;
//                     NSNumber *messageCount = [dataDictionay objectForKey:API_UNREAD_MESSAGE_COUNT];
//                     if (messageCount)
//                     {
//                         appdelegate.unReadMessageCount = messageCount;
//                     }
//                     [user saveUserToDefaults];
//                     if(shouldCache) {
//                         NSMutableDictionary *cachedDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@", USER_ID_CACHE_KEY, user.userID]]];
//                         if(!cachedDictionary)
//                         {
//                             cachedDictionary = [[NSMutableDictionary alloc] init];
//                         }
//                         if(dataDictionay) {
//                             [cachedDictionary setObject:dataDictionay forKey:urlString];
//                         }
//                         
//                         
//                         
//                         [[NSUserDefaults standardUserDefaults] setObject:cachedDictionary forKey:[NSString stringWithFormat:@"%@%@", USER_ID_CACHE_KEY, user.userID]];
//                         [[NSUserDefaults standardUserDefaults] synchronize];
//                     }
//                     
//                 }
//                 else
//                 {
//                     if(shouldCache) {
//                         NSMutableDictionary *cachedDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:NO_USER_ID_CACHE_KEY]];
//                         if(!cachedDictionary)
//                         {
//                             cachedDictionary = [[NSMutableDictionary alloc] init];
//                         }
//                         
//                         if(dataDictionay) {
//                             [cachedDictionary setObject:dataDictionay forKey:urlString];
//                         }
//                         
//                         [[NSUserDefaults standardUserDefaults] setObject:cachedDictionary forKey:NO_USER_ID_CACHE_KEY];
//                         [[NSUserDefaults standardUserDefaults] synchronize];
//                     }
//                     
//                 }
//             }
//             
//             [FUActivityIndicator stopAnimating];
//             if (successBlock)
//             {
//                 successBlock(responseObject);
//             }
//             debugLog( @"Response %@ ",responseObject);
//             
//             
//             //         if ([[result valueForKey:RESULT_CODE] isEqualToNumber:[NSNumber numberWithInt:SUCCESS_CODE]]) {
//             //             successBlock(result);
//             //
//             //         }
//             
//         }
//             failure:^(AFHTTPRequestOperation *operation, NSError *error)
//         {
//             debugLog(@"err %@",error);
//             
//             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//             [FUActivityIndicator stopAnimating];
//             [FUUtility showAlert:ALERT_TITLE_ERROR withCustomMessage:ALERT_GENERAL_NETWORK_ERROR havingOkButton:ALERT_BUTTON_OK andCancelButton:nil];
//             
//             if (failBlock)
//             {
//                 failBlock([error localizedDescription]);
//             }
//             
//         }];
//    }
//    else
//    {
//        FUUser *user = [FUUser currentLoggedInUser];
//        
//        [FUUtility showAlert:ALERT_TITLE_ERROR withCustomMessage:ALERT_NO_NETWORK_ERROR havingOkButton:ALERT_BUTTON_OK andCancelButton:nil];
//        NSDictionary *cacheResponseDictionary, *resposeDictionary;
//        if(user) {
//            cacheResponseDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@", USER_ID_CACHE_KEY, user.userID]];
//            
//        }
//        else
//        {
//            cacheResponseDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:NO_USER_ID_CACHE_KEY];
//        }
//        resposeDictionary = [cacheResponseDictionary objectForKey:urlString];
//        
//        
//        if(resposeDictionary)
//        {
//            successBlock(resposeDictionary);
//        }
//        
//    }
//}
//
//
////FileUpload
//
//
//
//+ (void) postRequestWithURLString:(NSString *)apiURL withFilePath:(NSURL *)filePathURL withSuccess:(void(^)(id object))successBlock andFail:(void(^)(NSString *errorMessage))failBlock
//{
//    
//    if ([self isNetWorkAvailable])
//    {
//        
//        
//        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:[FUAPIManager baseURL]]];
//        
//        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
//        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//        
//        [FUActivityIndicator startAnimating:YES];
//        
//        [responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
//        [manager setRequestSerializer:requestSerializer];
//        [manager setResponseSerializer:responseSerializer];
//        FUUser *user = [FUUser currentLoggedInUser];
//        if(user)
//        {
//            [manager.requestSerializer setValue:[NSString notNullString:user.apiUserToken] forHTTPHeaderField:@"authToken"];
//            [manager.requestSerializer setValue:[NSString notNullString:user.userID] forHTTPHeaderField:@"userID"];
//        }
//        [manager POST:apiURL
//           parameters:nil
//constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//         {
//             [formData appendPartWithFileURL:filePathURL name:@"tempimg" fileName:[filePathURL lastPathComponent] mimeType:[FUAPIManager getMimeType:filePathURL] error:nil];
//             debugLog(@"File name %@",[filePathURL lastPathComponent]);
//         }
//              success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             [FUActivityIndicator stopAnimating];
//             debugLog(@"response %@",responseObject);
//             
//             successBlock(responseObject);
//         }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error)
//         {
//             [FUActivityIndicator stopAnimating];
//             debugLog(@"error %@",error.localizedDescription);
//             [FUUtility showAlert:ALERT_TITLE_ERROR withCustomMessage:ALERT_GENERAL_NETWORK_ERROR havingOkButton:ALERT_BUTTON_OK andCancelButton:nil];
//             
//             failBlock(error.localizedDescription);
//         }];
//        
//    }
//    else
//    {
//        [FUUtility showAlert:ALERT_TITLE_ERROR withCustomMessage:ALERT_NO_NETWORK_ERROR havingOkButton:ALERT_BUTTON_OK andCancelButton:nil];
//        failBlock(@"");
//        
//        
//    }
//}
//
//+ (NSString *)getMimeType:(NSURL *)filePathURL
//{
//    NSString *mimeType = @"";
//    if ([[filePathURL pathExtension] caseInsensitiveCompare:@"mp4"] == NSOrderedSame)
//    {
//        mimeType = @"video/mp4";
//    }
//    else if ([[filePathURL pathExtension] caseInsensitiveCompare:@"m4a"] == NSOrderedSame)
//    {
//        mimeType = @"audio/mp4a-latm";
//    }
//    else if ([[filePathURL pathExtension] caseInsensitiveCompare:@"jpg"] == NSOrderedSame)
//    {
//        mimeType = @"image/jpeg";
//    }
//    return mimeType;
//}
//
//
//
//#pragma mark - Network Error Handling
//
//+ (BOOL)isNetWorkAvailable
//{
//    BOOL netWorkAvailable = NO;
////    //    NSString * errorMessage;
////    Reachability *reachability = [Reachability reachabilityForInternetConnection];
////    
////    if ([reachability currentReachabilityStatus] == NotReachable){
////        netWorkAvailable = NO;
////        //        errorMessage = NO_DATA_NETWORK_ALERT;
////        //        [FUUtility showAlertWithTitle:NO_DATA_NETWORK_ALERT_HEADER message:errorMessage delegate:nil];
////        return netWorkAvailable;
////    }
////    else{
////        //        errorMessage = SERVER_ERROR_ALERT;
////        //        [FAUtility showAlertWithTitle:SERVER_ERROR_ALERT_HEADER message:errorMessage delegate:nil];
////    }
////
//    if ([[AFNetworkReachabilityManager sharedManager]isReachable])
//    {
//        netWorkAvailable = YES;
//    }
//    
//    return netWorkAvailable;
//}
//
//


@end
