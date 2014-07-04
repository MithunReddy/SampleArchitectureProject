//
//  ICHActivityIndicator.h
//  SkeletonWebServiceProjectNOCD
//
//  Created by idev on 7/3/14.
//  Copyright (c) 2014 iChathan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICHActivityIndicator : UIActivityIndicatorView

+ (UIActivityIndicatorView *)sharedIndicatorView;
+ (void)startAnimating;
+ (void)stopAnimating;

@end
