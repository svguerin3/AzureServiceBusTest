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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AzureClient alloc] initWithBaseURL:[NSURL URLWithString:@""]]; // TODO: Read from plist
    });
    
    return _sharedClient;
}

//- (id)initWithBaseURL:(NSURL *)url {
//    self = [super initWithBaseURL:url];
//    if (!self) {
//        return nil;
//    }
//
//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/x-www-form-urlencoded", nil]];
//    
//    return self;
//}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableDictionary *allParameters = [parameters mutableCopy];
    if (allParameters == nil) {
        allParameters = [[NSMutableDictionary alloc] init];
    }
    if ([AzureUser currentUser]) {
        [allParameters setValue:[[AzureUser currentUser] azureToken] forKey:@"token"];
    }
    [super postPath:path parameters:allParameters success:success failure:failure];
}

@end
