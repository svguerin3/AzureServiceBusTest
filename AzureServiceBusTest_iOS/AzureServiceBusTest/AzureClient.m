//
//  AzureClient.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureClient.h"
#import "AzureUser.h"

static NSString * const kBaseAPIURL = @"https://dorfbus-sb.accesscontrol.windows.net/";

@implementation AzureClient

+ (AzureClient *)sharedClient {
    static AzureClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AzureClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseAPIURL]];
    });
    
    return _sharedClient;
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableDictionary *allParameters = [parameters mutableCopy];
    if (allParameters == nil) {
        allParameters = [[NSMutableDictionary alloc] init];
    }
    if ([AzureUser currentUser]) {
        [self setAuthorizationHeaderWithToken:[NSString stringWithFormat:@"WRAP access_token=%@", [[AzureUser currentUser] azureToken]]];
    }
    [super postPath:path parameters:allParameters success:success failure:failure];
}

@end
