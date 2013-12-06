//
//  AzureUser.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureUser.h"
#import "AzureClient.h"

@implementation AzureUser

static AzureUser *_loggedInUser;

+ (AzureUser *)currentUser {
    return _loggedInUser;
}

+ (void)initUserWithToken:(NSString *)azureToken {
    _loggedInUser = [[AzureUser alloc] init];
    _loggedInUser.azureToken = azureToken;
}

+ (void)authenticateAzureUserWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure {
    NSString *apiEndpoint = [NSString stringWithFormat:@""];
    NSDictionary *parameters = @{@"wrap_scope": [AzureUtils fetchFromPlistWithKey:kPlistKeyEndPoint],
                                 @"wrap_name": [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName],
                                 @"wrap_password": [AzureUtils fetchFromPlistWithKey:kPlistKeyPassword]};
    
    [[AzureClient sharedClient] postPath:apiEndpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // TODO :Implement
        
        NSLog(@"Success! responseObj: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)logoutUser {
    _loggedInUser = nil;
    _loggedInUser.azureToken = nil;
}

@end
