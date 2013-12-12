//
//  AzureDataManager.h
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/12/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AzureDataManager : NSObject

+ (AzureDataManager*)sharedInstance;

- (void) postMethodWithBaseUrl:(NSString *)baseUrlString
                      endPoint:(NSString *)endPointString
                    parameters:(NSDictionary *)parametersDict
                   requestBody:(NSString *)requestBody
              authHeaderString:(NSString *)authHeader
                       success:(void (^)(NSString *responseString))success failure:(void (^)(NSError *error))failure;

@end
