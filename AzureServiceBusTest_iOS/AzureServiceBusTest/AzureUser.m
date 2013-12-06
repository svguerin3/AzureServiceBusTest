//
//  AzureUser.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureUser.h"
#import "AzureClient.h"

#define API_AUTHENTICATE_ENDPOINT   @"WRAPv0.9"

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
    NSString *wrapScopeParameter = [NSString stringWithFormat:@"http://%@.servicebus.windows.net/", [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName]];
    NSDictionary *parameters = @{@"wrap_scope": wrapScopeParameter,
                                 @"wrap_name": [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName],
                                 @"wrap_password": [AzureUtils fetchFromPlistWithKey:kPlistKeyPassword]};

    [[AzureClient sharedClient] postPath:API_AUTHENTICATE_ENDPOINT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"resultString: %@", resultString);
        
        [self initUserWithToken:resultString];
        
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)logoutUser {
    _loggedInUser = nil;
    _loggedInUser.azureToken = nil;
}

@end
