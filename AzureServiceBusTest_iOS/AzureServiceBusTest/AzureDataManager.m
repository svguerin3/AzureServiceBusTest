//
//  AzureDataManager.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/12/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureDataManager.h"
#import <RestKit/RestKit.h>

@implementation AzureDataManager

#pragma mark - Singleton Methods

+ (AzureDataManager *)sharedInstance {
    static AzureDataManager *sharedInstance;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[AzureDataManager alloc] init];
        }
        return sharedInstance;
    }
}

#pragma mark - Data methods

- (void) postMethodWithBaseUrl:(NSString *)baseUrlString
                      endPoint:(NSString *)endPointString
                    parameters:(NSDictionary *)parametersDict
                   requestBody:(NSString *)requestBody
               authHeaderString:(NSString *)authHeader
                        success:(void (^)(NSString *responseString))success failure:(void (^)(NSError *error))failure {

    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlString]];
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:endPointString parameters:parametersDict];

    if (authHeader) {
        [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    }
    
    if (requestBody) {
        [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(resultString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [operation start];
}

@end
