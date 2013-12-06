//
//  AzureUtils.h
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPlistKeyServiceBusName     @"Service Bus Name"
#define kPlistKeyServiceQueueName   @"Service Queue Name"
#define kPlistKeyUserName           @"Azure Username"
#define kPlistKeyPassword           @"Azure Password"

@interface AzureUtils : NSObject

+ (NSString *)fetchFromPlistWithKey:(NSString *)keyString;

@end
