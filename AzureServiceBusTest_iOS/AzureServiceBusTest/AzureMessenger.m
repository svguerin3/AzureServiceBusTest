//
//  AzureMessenger.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureMessenger.h"
#import "AzureDataManager.h"
#import "AzureUser.h"

#define API_MESSAGES_ENDPOINT   @"messages"

@implementation AzureMessenger

+ (void)sendMessageToQueue:(NSString *)messageString success:(void (^)())success failure:(void (^)(NSError *error))failure {
    NSString *baseUrlString = [NSString stringWithFormat:@"https://%@.servicebus.Windows.net/%@/",
                        [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName],
                        [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceQueueName]];
    
    NSString *authHeaderString = [[NSString stringWithFormat:@"WRAP access_token=\"%@\"", [[AzureUser currentUser] azureToken]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AzureDataManager sharedInstance] postMethodWithBaseUrl:baseUrlString endPoint:API_MESSAGES_ENDPOINT parameters:nil requestBody:messageString authHeaderString:authHeaderString success:^(NSString *responseString) {
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
