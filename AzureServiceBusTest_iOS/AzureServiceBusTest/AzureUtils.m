//
//  AzureUtils.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureUtils.h"

#define kPlistFileName  @"AzureLogin-Info"

@implementation AzureUtils

+ (NSString *)fetchFromPlistWithKey:(NSString *)keyString {
    NSDictionary *plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kPlistFileName ofType:@"plist"]];
    return [plistDictionary objectForKey:keyString];
}

@end
