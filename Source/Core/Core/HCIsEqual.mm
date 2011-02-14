//
//  OCHamcrest - HCIsEqual.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCIsEqual.h"

    // OCHamcrest
#import "HCDescription.h"


@implementation HCIsEqual

+ (id)isEqualTo:(id)anObject;
{
    return [[[self alloc] initEqualTo:anObject] autorelease];
}


- (id)initEqualTo:(id)anObject
{
    self = [super init];
    if (self != nil)
        object = [anObject retain];
    return self;
}


- (void)dealloc
{
    [object release];
    [super dealloc];
}


- (BOOL)matches:(id)item
{
    if (item == nil)
        return object == nil;
    else
        return [item isEqual:object];
}


- (void)describeTo:(id<HCDescription>)description
{
    if ([object conformsToProtocol:@protocol(HCMatcher)])
    {
        [[[description appendText:@"<"]
                       appendDescriptionOf:object]
                       appendText:@">"];
    }
    else
        [description appendDescriptionOf:object];
}

@end

//--------------------------------------------------------------------------------------------------

OBJC_EXPORT id<HCMatcher> HC_equalTo(id object)
{
    return [HCIsEqual isEqualTo:object];
}
