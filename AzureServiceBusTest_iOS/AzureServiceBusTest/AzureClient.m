//
//  AzureClient.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureClient.h"
#import "AzureUser.h"

@implementation AzureClient

+ (AzureClient *)sharedClient {
    static AzureClient *_sharedClient = nil;

    if ([AzureUser currentUser]) {
        NSString *apiURL = [NSString stringWithFormat:@"https://%@.servicebus.Windows.net/%@/",
                                [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName],
                                [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceQueueName]];
        _sharedClient = [[AzureClient alloc] initWithBaseURL:[NSURL URLWithString:apiURL]];
    } else {
        NSString *apiURL = [NSString stringWithFormat:@"https://%@-sb.accesscontrol.windows.net/",
                                [AzureUtils fetchFromPlistWithKey:kPlistKeyServiceBusName]];
        _sharedClient = [[AzureClient alloc] initWithBaseURL:[NSURL URLWithString:apiURL]];
    }
    
    return _sharedClient;
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableDictionary *allParameters = [parameters mutableCopy];
    if (allParameters == nil) {
        allParameters = [[NSMutableDictionary alloc] init];
    }

    if ([AzureUser currentUser]) {
        NSString *authHeaderString = [[NSString stringWithFormat:@"WRAP access_token=\"%@\"", [[AzureUser currentUser] azureToken]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self setDefaultHeader:@"Authorization" value:authHeaderString];
        
    }
    [super postPath:path parameters:allParameters success:success failure:failure];
}

@end
