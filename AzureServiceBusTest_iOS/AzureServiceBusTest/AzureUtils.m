//
//  AzureUtils.m
//  AzureServiceBusTest
//
//  Created by Vincent Guerin on 12/5/13.
//  Copyright (c) 2013 Neudesic. All rights reserved.
//

#import "AzureUtils.h"

@implementation AzureUtils

+ (NSString *)fetchFromPlistWithKey:(NSString *)keyString {
    NSArray *plistArrayOfDictionaries = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AzureServiceBusTest-Info" ofType:@"plist"]];
    for (NSDictionary *plistDict in plistArrayOfDictionaries) {
        NSString *resultValueString = [plistDict objectForKey:keyString];
        if (resultValueString) {
            return resultValueString;
        }
    }
    
    return @"";
}

@end
