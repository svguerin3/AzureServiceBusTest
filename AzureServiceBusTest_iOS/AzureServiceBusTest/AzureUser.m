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

#define kWrapScopeServiceBusSite        @"servicebus.windows.net"
#define kAuthKeyWrapAccessToken         @"wrap_access_token"
#define kAuthKeyWrapScope               @"wrap_scope"
#define kAuthKeyWrapName                @"wrap_name"
#define kAuthKeyWrapPassword            @"wrap_password"

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
    NSString *wrapScopeParameter = [NSString stringWithFormat:@"http://%@.%@/", [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName], kWrapScopeServiceBusSite];
    NSDictionary *parameters = @{kAuthKeyWrapScope: wrapScopeParameter,
                                 kAuthKeyWrapName: [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName],
                                 kAuthKeyWrapPassword: [AzureUtils fetchFromPlistWithKey:kPlistKeyPassword]};

    [[AzureClient sharedClient] postPath:API_AUTHENTICATE_ENDPOINT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        [self initUserWithToken:[self fetchTokenFromAuthResponse:resultString]];
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (NSString *)fetchTokenFromAuthResponse:(NSString *)authResponse {
    NSString *returnVal = @"";
    if ([authResponse length]) {
        NSArray *paramsArray = [authResponse componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramsArray) {
            if ([paramString rangeOfString:kAuthKeyWrapAccessToken].location != NSNotFound) {
                returnVal = [paramString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@=", kAuthKeyWrapAccessToken] withString:@""];
                break;
            }
        }
    }
    
    return returnVal;
}

+ (void)logoutUser {
    _loggedInUser = nil;
    _loggedInUser.azureToken = nil;
}

@end
