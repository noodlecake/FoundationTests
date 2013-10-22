#import "FoundationTests.h"

@testcase(NSNumberFormatter)

- (BOOL) testNSNumberFormatterInit
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    testassert([formatter allowsFloats]);
    testassert([formatter formatterBehavior] == NSNumberFormatterBehavior10_4);
    testassert([[formatter nilSymbol] isEqualToString:@""]);
    testassert([[formatter negativeInfinitySymbol] isEqualToString:[NSString stringWithUTF8String:"-∞"]]);
    testassert([[formatter positiveInfinitySymbol] isEqualToString:[NSString stringWithUTF8String:"+∞"]]);
    [formatter release];
    return YES;
}

- (BOOL) testNSNumberFormatterDecimal
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedOutput = [formatter stringFromNumber:@1234567];
    testassert([formattedOutput isEqualToString:@"1,234,567"]);
    [formatter release];
    return YES;
}

- (BOOL) testNSNumberFormatterDecimalFloat
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedOutput = [formatter stringFromNumber:[NSNumber numberWithFloat:12.932f]];
    testassert([formattedOutput isEqualToString:@"12.932"]);
    [formatter release];
    return YES;
}

- (BOOL) testNSNumberFormatterPercent
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSString *formattedOutput = [formatter stringFromNumber:[NSNumber numberWithFloat:12.932f]];
    testassert([formattedOutput isEqualToString:@"1,293%"]);
    [formatter release];
    return YES;
}

- (BOOL) testNSNumberFormatterSpellOut
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSString *formattedOutput = [formatter stringFromNumber:@1203456789];
    testassert([formattedOutput isEqualToString:@"one billion two hundred three million four hundred fifty-six thousand seven hundred eighty-nine"]);
    [formatter release];
    return YES;
}

- (BOOL) testNSNumberFormatterCurrency
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *formattedOutput = [formatter stringFromNumber:[NSNumber numberWithFloat:12.932f]];
    testassert([formattedOutput isEqualToString:@"$12.93"]);
    [formatter release];
    return YES;
}

@end
