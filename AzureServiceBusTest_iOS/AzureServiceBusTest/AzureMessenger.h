//
//  AzureMessenger.h
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AzureMessenger : NSObject

+ (void)sendMessageToQueue:(NSString *)messageString success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
