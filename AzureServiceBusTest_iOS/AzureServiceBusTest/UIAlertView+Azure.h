//
//  UIAlertView+Azure.h
//  Neudesic
//
//  Created by Created by Vincent Guerin on 12/5/2013.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

@interface UIAlertView (Azure)

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

@end
