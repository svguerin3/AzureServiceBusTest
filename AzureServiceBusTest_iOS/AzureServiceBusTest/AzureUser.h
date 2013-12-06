//
//  AzureUser.h
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AzureUser : NSObject

@property (nonatomic, strong) NSString *azureToken;

+ (AzureUser*)currentUser;
+ (void)initUserWithToken:(NSString *)azureToken;
+ (void)authenticateAzureUserWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
+ (void)logoutUser;

@end
