//
//  UIAlertView+Azure.m
//  Neudesic
//
//  Created by Vincent Guerin on 12/5/2013.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "UIAlertView+Azure.h"
#import <objc/runtime.h>

@implementation UIAlertView (Azure)

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message {
    
    return [UIAlertView alertViewWithTitle:title
                                   message:message
                         cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")];
}

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: nil];
    [alert show];
    return alert;
}

@end
