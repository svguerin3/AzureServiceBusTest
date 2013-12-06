//
//  AzureClient.h
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface AzureClient : AFHTTPClient

+ (AzureClient*)sharedClient;

@end
