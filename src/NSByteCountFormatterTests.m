#import "FoundationTests.h"

@testcase(NSByteCountFormatter)

static NSArray *unitStrings;

+ (void)initialize
{
    unitStrings = [@[@"bytes", @"KB", @"MB", @"GB", @"TB", @"PB", @"EB", @"ZB", @"YB"] retain];
}

- (BOOL)testCreation
{
    NSByteCountFormatter *formatter = [NSByteCountFormatter alloc];
    testassert(formatter != nil);
    [formatter release];

    return YES;
}

- (BOOL)testInit
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];

    testassert([formatter allowedUnits] == NSByteCountFormatterUseDefault);
    testassert([formatter countStyle] == NSByteCountFormatterCountStyleFile);
    testassert([formatter allowsNonnumericFormatting]);
    testassert([formatter includesUnit]);
    testassert([formatter includesCount]);
    testassert(![formatter includesActualByteCount]);
    testassert([formatter isAdaptive]);
    testassert(![formatter zeroPadsFractionDigits]);

    [formatter release];

    return YES;
}

// Zero byte counts may be printed specially.
- (BOOL)testZeroBytes
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];

    NSString *zeroByteString = [formatter stringFromByteCount:0];
    testassert([zeroByteString isEqual:@"Zero KB"]);

    [zeroByteString release];
    [formatter release];

    return YES;
}

- (BOOL)testZeroBytesWithBytes
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.allowedUnits = NSByteCountFormatterUseBytes;

    NSString *zeroByteString = [formatter stringFromByteCount:0];
    testassert([zeroByteString isEqual:@"Zero bytes"]);

    [zeroByteString release];
    [formatter release];

    return YES;
}

- (BOOL)testZeroBytesWithKilobytes
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.allowedUnits = NSByteCountFormatterUseKB;

    NSString *zeroByteString = [formatter stringFromByteCount:0];
    testassert([zeroByteString isEqual:@"Zero KB"]);

    [zeroByteString release];
    [formatter release];

    return YES;
}

- (BOOL)testZeroBytesWithoutNonnumericFormatting
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.allowsNonnumericFormatting = NO;

    NSString *zeroByteString = [formatter stringFromByteCount:0];
    testassert([zeroByteString isEqual:@"0 bytes"]);

    [zeroByteString release];
    [formatter release];

    return YES;
}

- (BOOL)testBinarySizes
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.adaptive = NO;

    formatter.countStyle = NSByteCountFormatterCountStyleBinary;

    long long byteCount = 2;
    for (NSUInteger idx = 0; idx < 7; idx++)
    {
        NSString *byteString = [formatter stringFromByteCount:byteCount];
        NSString *unitString = [unitStrings objectAtIndex:idx];
        NSString *expectedByteString = [NSString stringWithFormat:@"2 %@", unitString];

        testassert([byteString isEqual:expectedByteString]);

        byteCount *= 1024;
    }

    return YES;
}

- (BOOL)testDecimalSizes
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.adaptive = NO;

    long long byteCount = 2;
    for (NSUInteger idx = 0; idx < 7; idx++)
    {
        NSString *byteString = [formatter stringFromByteCount:byteCount];
        NSString *unitString = [unitStrings objectAtIndex:idx];
        NSString *expectedByteString = [NSString stringWithFormat:@"2 %@", unitString];

        testassert([byteString isEqual:expectedByteString]);

        byteCount *= 1000;
    }

    return YES;
}

- (BOOL)testActualByteCount
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.adaptive = NO;

    formatter.includesActualByteCount = YES;

    NSUInteger byteCount = 2 * 1000 * 1000;
    NSString *byteString = [formatter stringFromByteCount:byteCount];
    testassert([byteString isEqual:@"2 MB (2,000,000 bytes)"]);

    [formatter release];

    return YES;
}

- (BOOL)testExcludesUnit
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.adaptive = NO;

    formatter.includesUnit = NO;

    NSString *byteString = [formatter stringFromByteCount:42 * 1000];
    testassert([byteString isEqual:@"42"]);

    [formatter release];

    return YES;
}

- (BOOL)testExcludesCount
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    formatter.adaptive = NO;

    formatter.includesCount = NO;

    NSString *byteString = [formatter stringFromByteCount:42 * 1000 * 1000];
    testassert([byteString isEqual:@"MB"]);

    [formatter release];

    return YES;
}

@end
