//
//  OCHamcrest - HCIsInstanceOf.mm
//  Copyright 2010 www.hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCIsInstanceOf.h"

    // OCHamcrest
#import "HCDescription.h"


@implementation HCIsInstanceOf

+ (HCIsInstanceOf*) isInstanceOf:(Class)type
{
    return [[[HCIsInstanceOf alloc] initWithType:type] autorelease];
}


- (id) initWithType:(Class)type
{
    self = [super init];
    if (self != nil)
        theClass = type;
    return self;
}


- (BOOL) matches:(id)item
{
    return [item isKindOfClass:theClass];
}


- (void) describeTo:(id<HCDescription>)description
{
    [[description appendText:@"an instance of "]
                    appendText:NSStringFromClass(theClass)];
}

@end


OBJC_EXPORT id<HCMatcher> HC_instanceOf(Class type)
{
    return [HCIsInstanceOf isInstanceOf:type];
}
