//
//  AzureMessenger.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureMessenger.h"
#import "AzureClient.h"

#define API_MESSAGES_ENDPOINT   @"messages"

@implementation AzureMessenger

+ (void)sendMessageToQueue:(NSString *)messageString success:(void (^)())success failure:(void (^)(NSError *error))failure {
    [[AzureClient sharedClient] postPath:API_MESSAGES_ENDPOINT parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"resultString: %@", resultString);
        
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
