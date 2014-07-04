//
//  ICHPersonFetcher.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/4/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHPersonFetcher.h"
#import "ICHPersonAPIManager.h"
#import "ICHPerson+Operations.h"

@implementation ICHPersonFetcher


+ (void)fetchPersonsWithPageID:(NSString *)pageID withCompletionBlock:(void(^)(NSArray * personArray))completionBlock failureBlock:(void(^)(id object))failureBlock showIndicator:(BOOL)showIndicator
{
    [ICHPersonAPIManager fetchPersonsWithPaginationPageId:pageID completionBlock:^(id object) {
        
        NSDictionary *responseDictionary = (NSDictionary *)object;
        NSMutableArray *personArray = [NSMutableArray array];

        if ([(NSString *)responseDictionary[API_GENERAL_DATA_KEY_RESPONSE_CODE] isEqualToString:API_GENERAL_RESPONSE_CODE_SUCCESS])
        {
            NSDictionary *payloadDictionary = responseDictionary[API_GENERAL_DATA_KEY_PAYLOAD];
            NSArray *personDataArray = payloadDictionary[API_SAMPLE_API_DATA_KEY_OBJECT_LIST];
            
            for (NSDictionary *personDictionary in personDataArray)
            {
                ICHPerson *person = [ICHPerson personWithData:personDictionary];
                [personArray addObject:person];
            }
            
            completionBlock(personArray);
            
        }
        
    } failureBlock:^(id object) {
        failureBlock(object);
        
    } showIndicator:showIndicator];
}

@end
