//
//  OCHamcrest - IsTest.m
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import "AbstractMatcherTest.h"

    // OCHamcrest
#define HC_SHORTHAND
#import <OCHamcrest/HCIs.h>
#import <OCHamcrest/HCIsEqual.h>

    // Test support
#import "NeverMatch.h"


@interface IsTest : AbstractMatcherTest
@end

@implementation IsTest

- (id<HCMatcher>)createMatcher
{
    return is(@"something");
}


- (void)testDelegatesMatchingToNestedMatcher
{
    assertMatches(@"should match", is(equalTo(@"A")), @"A");
    assertMatches(@"should match", is(equalTo(@"B")), @"B");
    assertDoesNotMatch(@"should not match", is(equalTo(@"A")), @"B");
    assertDoesNotMatch(@"should not match", is(equalTo(@"B")), @"A");
}


- (void)testDescriptionShouldPassThrough
{
    assertDescription(@"\"A\"", is(equalTo(@"A")));
}


- (void)testProvidesConvenientShortcutForIsEqualTo
{
    assertMatches(@"should match", is(@"A"), @"A");
    assertMatches(@"should match", is(@"B"), @"B");
    assertDoesNotMatch(@"should not match", is(@"A"), @"B");
    assertDoesNotMatch(@"should not match", is(@"B"), @"A");
    assertDescription(@"\"A\"", is(@"A"));
}


- (void)testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(is(@"A"), @"A");
}


- (void)testDelegatesMismatchDescriptionToNestedMatcher
{
    assertMismatchDescription([NeverMatch mismatchDescription],
                              is([NeverMatch neverMatch]),
                              @"hi");
}


- (void)testDelegatesDescribeMismatchToNestedMatcher
{
    assertDescribeMismatch([NeverMatch mismatchDescription],
                           is([NeverMatch neverMatch]),
                           @"hi");
}

@end
