//
//  OCHamcrest - HCHasDescription.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCHasDescription.h"

    // OCHamcrest
#import "HCDescription.h"
#import "HCWrapInMatcher.h"


@implementation HCHasDescription

+ (id)hasDescription:(id<HCMatcher>)descriptionMatcher
{
    return [[[self alloc] initWithDescription:descriptionMatcher] autorelease];
}


- (id)initWithDescription:(id<HCMatcher>)descriptionMatcher;
{
    NSInvocation *anInvocation = [HCInvocationMatcher invocationForSelector:@selector(description)
                                                                    onClass:[NSObject class]];
    self = [super initWithInvocation:anInvocation matching:descriptionMatcher];
    shortMismatchDescription = YES;
    return self;
}

@end


OBJC_EXPORT id<HCMatcher> HC_hasDescription(id matcherOrValue)
{
    return [HCHasDescription hasDescription:HCWrapInMatcher(matcherOrValue)];
}
