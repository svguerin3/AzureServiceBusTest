//
//  AzureUser.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureUser.h"
#import "AzureDataManager.h"

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
    NSString *baseUrlString = [NSString stringWithFormat:@"https://%@-sb.accesscontrol.windows.net/",
                                   [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName]];
    
    NSString *wrapScopeParameter = [NSString stringWithFormat:@"http://%@.servicebus.windows.net/", [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName]];
    NSDictionary *parameters = @{@"wrap_scope": wrapScopeParameter,
                                 @"wrap_name": [AzureUtils fetchFromPlistWithKey:kPlistKeyUserName],
                                 @"wrap_password": [AzureUtils fetchFromPlistWithKey:kPlistKeyPassword]};

    [[AzureDataManager sharedInstance] postMethodWithBaseUrl:baseUrlString endPoint:API_AUTHENTICATE_ENDPOINT parameters:parameters requestBody:nil authHeaderString:nil success:^(NSString *responseString) {
        [self initUserWithToken:[self fetchTokenFromAuthResponse:responseString]];
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSString *)fetchTokenFromAuthResponse:(NSString *)authResponse {
    NSString *returnVal = @"";
    if ([authResponse length]) {
        NSArray *paramsArray = [authResponse componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramsArray) {
            if ([paramString rangeOfString:@"wrap_access_token="].location != NSNotFound) {
                returnVal = [paramString stringByReplacingOccurrencesOfString:@"wrap_access_token=" withString:@""];
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
