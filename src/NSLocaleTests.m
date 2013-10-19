//
//  NSLocaleTests.m
//  FoundationTests
//
//  Created by Paul Beusterien on 10/16/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "FoundationTests.h"

@testcase(NSLocale)



- (BOOL)testPreferredLanguages
{
    NSArray *langs = [NSLocale preferredLanguages];
    testassert([langs count] >= 1);
    NSString *myLanguage = [langs objectAtIndex:0];
    testassert([myLanguage isEqualToString:@"en"]);  // Will fail on non English speaking devices
    
    return YES;
}


@end