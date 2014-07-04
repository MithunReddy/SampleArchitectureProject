//
//  ICHActivityIndicator.m
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import "ICHActivityIndicator.h"

@implementation ICHActivityIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UIActivityIndicatorView *)sharedIndicatorView {
    static dispatch_once_t once;
    static UIActivityIndicatorView *sharedIndicator;
    dispatch_once(&once, ^{
        sharedIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        sharedIndicator.hidesWhenStopped = YES;
        sharedIndicator.color = [UIColor colorWithRed:23/255.0 green:23/255.0 blue:23/255.0 alpha:1.0];
    });
    
    return sharedIndicator;
}

+ (void)startAnimating
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
            UIActivityIndicatorView *sharedIndicator = [ICHActivityIndicator sharedIndicatorView];
            
            UIWindow *window = [[UIApplication sharedApplication].delegate window];
            [window addSubview:sharedIndicator];
            
            sharedIndicator.center = window.center;
            [sharedIndicator startAnimating];
            
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
    });
    
    
}


+ (void)stopAnimating
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIActivityIndicatorView *sharedIndicator = [ICHActivityIndicator sharedIndicatorView];
        [sharedIndicator stopAnimating];
        [sharedIndicator removeFromSuperview];
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
        {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
}


@end
