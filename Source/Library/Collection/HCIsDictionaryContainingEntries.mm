//
//  OCHamcrest - HCIsDictionaryContainingEntries.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCIsDictionaryContainingEntries.h"

    // OCHamcrest
#import "HCDescription.h"
#import "HCWrapInMatcher.h"


@implementation HCIsDictionaryContainingEntries

+ (id)isDictionaryContainingKeys:(NSArray *)theKeys
                   valueMatchers:(NSArray *)theValueMatchers
{
    return [[[self alloc] initWithKeys:theKeys valueMatchers:theValueMatchers] autorelease];
}


- (id)initWithKeys:(NSArray *)theKeys
     valueMatchers:(NSArray *)theValueMatchers
{
    self = [super init];
    if (self != nil)
    {
        keys = [theKeys retain];
        valueMatchers = [theValueMatchers retain];
    }
    return self;
}


- (void)dealloc
{
    [valueMatchers release];
    [keys release];
    
    [super dealloc];
}


- (BOOL)matches:(id)item
{
    return [self matches:item describingMismatchTo:nil];
}


- (BOOL)matches:(id)dict describingMismatchTo:(id<HCDescription>)mismatchDescription
{
    if (![dict isKindOfClass:[NSDictionary class]])
    {
        [super describeMismatchOf:dict to:mismatchDescription];
        return NO;
    }
    
    NSUInteger count = [keys count];
    for (NSUInteger index = 0; index < count; ++index)
    {
        id key = [keys objectAtIndex:index];
        if ([dict objectForKey:key] == nil)
        {
            [[[[mismatchDescription appendText:@"no "]
                                    appendDescriptionOf:key]
                                    appendText:@" key in "]
                                    appendDescriptionOf:dict];
            return NO;
        }

        id valueMatcher = [valueMatchers objectAtIndex:index];
        id actualValue = [dict objectForKey:key];
        
        if (![valueMatcher matches:actualValue])
        {
            [[[[mismatchDescription appendText:@"value for "]
                                    appendDescriptionOf:key]
                                    appendText:@" was "]
                                    appendDescriptionOf:actualValue];
            return NO;
        }
    }    
    
    return YES;
}


- (void)describeMismatchOf:(id)item to:(id<HCDescription>)mismatchDescription
{
    (void) [self matches:item describingMismatchTo:mismatchDescription];
}


/// Describes key-value pair at given index.
- (void)describeKeyValueAtIndex:(NSUInteger)index to:(id<HCDescription>)description
{
    [[[[description appendDescriptionOf:[keys objectAtIndex:index]]
                    appendText:@" = "]
                    appendDescriptionOf:[valueMatchers objectAtIndex:index]]
                    appendText:@"; "];
}


- (void)describeTo:(id<HCDescription>)description
{
    [description appendText:@"a dictionary containing { "];
    NSUInteger count = [keys count];
    NSUInteger index = 0;
    for (; index < count - 1; ++index)
        [self describeKeyValueAtIndex:index to:description];
    [self describeKeyValueAtIndex:index to:description];
    [description appendText:@"}"];
}

@end

//--------------------------------------------------------------------------------------------------

static void requirePairedObject(id obj)
{
    if (obj == nil)
    {
        @throw [NSException exceptionWithName:@"NilObject"
                                       reason:@"HC_hasEntries keys and value matchers must be paired"
                                     userInfo:nil];
    }
}


OBJC_EXPORT id<HCMatcher> HC_hasEntries(id keysAndValueMatchers, ...)
{
    va_list args;
    va_start(args, keysAndValueMatchers);
    
    id key = keysAndValueMatchers;
    id valueMatcher = va_arg(args, id);
    requirePairedObject(valueMatcher);
    NSMutableArray *keys = [NSMutableArray arrayWithObject:key];
    NSMutableArray *valueMatchers = [NSMutableArray arrayWithObject:HCWrapInMatcher(valueMatcher)];

    key = va_arg(args, id);
    while (key != nil)
    {
        [keys addObject:key];
        valueMatcher = va_arg(args, id);
        requirePairedObject(valueMatcher);
        [valueMatchers addObject:HCWrapInMatcher(valueMatcher)];
        key = va_arg(args, id);
    }
    
    return [HCIsDictionaryContainingEntries isDictionaryContainingKeys:keys
                                                         valueMatchers:valueMatchers];
}
