//
//  OCHamcrest - HCNumberAssert.mm
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCNumberAssert.h"

    // OCHamcrest
#import "HCAssertThat.h"
#import "HCBoxNumber.h"
using namespace hamcrest;


#define DEFINE_NUMBER_ASSERT(name, type)                                                        \
    OBJC_EXPORT void HC_assertThat ## name ## WithLocation(id testCase, type actual, id<HCMatcher> matcher, \
                                                    const char* fileName, int lineNumber)       \
    {                                                                                           \
        HC_assertThatWithLocation(testCase, boxNumber(actual), matcher, fileName, lineNumber);  \
    }

DEFINE_NUMBER_ASSERT(Bool, BOOL)
DEFINE_NUMBER_ASSERT(Char, char)
DEFINE_NUMBER_ASSERT(Double, double)
DEFINE_NUMBER_ASSERT(Float, float)
DEFINE_NUMBER_ASSERT(Int, int)
DEFINE_NUMBER_ASSERT(Long, long)
DEFINE_NUMBER_ASSERT(LongLong, long long)
DEFINE_NUMBER_ASSERT(Short, short)
DEFINE_NUMBER_ASSERT(UnsignedChar, unsigned char)
DEFINE_NUMBER_ASSERT(UnsignedInt, unsigned int)
DEFINE_NUMBER_ASSERT(UnsignedLong, unsigned long)
DEFINE_NUMBER_ASSERT(UnsignedLongLong, unsigned long long)
DEFINE_NUMBER_ASSERT(UnsignedShort, unsigned short)
DEFINE_NUMBER_ASSERT(Integer, NSInteger)
DEFINE_NUMBER_ASSERT(UnsignedInteger, NSUInteger)
