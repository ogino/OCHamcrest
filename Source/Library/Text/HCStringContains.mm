//
//  OCHamcrest - HCStringContains.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCStringContains.h"

    // OCHamcrest
#import "HCDescription.h"


@implementation HCStringContains

+ (id)stringContains:(NSString *)aSubstring
{
    return [[[self alloc] initWithSubstring:aSubstring] autorelease];
}


- (BOOL)matches:(id)item
{
    if (![item respondsToSelector:@selector(rangeOfString:)])
        return NO;
    
    return [item rangeOfString:substring].location != NSNotFound;
}


- (NSString *)relationship
{
    return @"containing";
}

@end

//--------------------------------------------------------------------------------------------------

OBJC_EXPORT id<HCMatcher> HC_containsString(NSString *aSubstring)
{
    return [HCStringContains stringContains:aSubstring];
}
