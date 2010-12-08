//
//  OCHamcrest - HCIsEqualToNumber.mm
//  Copyright 2010 www.hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Self
#import "HCIsEqualToNumber.h"

    // OCHamcrest
#import "HCBoxNumber.h"
#import "HCIsEqual.h"
using namespace hamcrest;


#define DEFINE_EQUAL_TO_NUMBER(name, type)                      \
    OBJC_EXPORT id<HCMatcher> HC_equalTo ## name(type value)    \
    {                                                           \
        return [HCIsEqual isEqualTo:boxNumber(value)];          \
    }

DEFINE_EQUAL_TO_NUMBER(Bool, BOOL)
DEFINE_EQUAL_TO_NUMBER(Char, char)
DEFINE_EQUAL_TO_NUMBER(Double, double)
DEFINE_EQUAL_TO_NUMBER(Float, float)
DEFINE_EQUAL_TO_NUMBER(Int, int)
DEFINE_EQUAL_TO_NUMBER(Long, long)
DEFINE_EQUAL_TO_NUMBER(LongLong, long long)
DEFINE_EQUAL_TO_NUMBER(Short, short)
DEFINE_EQUAL_TO_NUMBER(UnsignedChar, unsigned char)
DEFINE_EQUAL_TO_NUMBER(UnsignedInt, unsigned int)
DEFINE_EQUAL_TO_NUMBER(UnsignedLong, unsigned long)
DEFINE_EQUAL_TO_NUMBER(UnsignedLongLong, unsigned long long)
DEFINE_EQUAL_TO_NUMBER(UnsignedShort, unsigned short)
DEFINE_EQUAL_TO_NUMBER(Integer, NSInteger)
DEFINE_EQUAL_TO_NUMBER(UnsignedInteger, NSUInteger)
