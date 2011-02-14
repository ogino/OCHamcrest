//
//  OCHamcrest - IsCollectionContainingTest.m
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Class under test
#define HC_SHORTHAND
#import <OCHamcrest/HCIsCollectionContaining.h>

    // Other OCHamcrest
#import <OCHamcrest/HCIsEqual.h>

    // Test support
#import "AbstractMatcherTest.h"


@interface IsCollectionContainingTest : AbstractMatcherTest
@end

@implementation IsCollectionContainingTest

- (id<HCMatcher>)createMatcher
{
    return hasItem(equalTo(@"irrelevant"));
}


- (void)testMatchesACollectionThatContainsAnElementMatchingTheGivenMatcher
{
    assertMatches(@"list contains 'a'",
                  hasItem(equalTo(@"a")), ([NSArray arrayWithObjects:@"a", @"b", @"c", nil]));
}


- (void)testNoMatchIfCollectionDoesntContainAnElementMatchingTheGivenMatcher
{
    assertDoesNotMatch(@"list without 'a'",
                       hasItem(equalTo(@"a")), ([NSArray arrayWithObjects:@"b", @"c", nil]));    
    assertDoesNotMatch(@"empty", hasItem(equalTo(@"a")), [NSArray array]);
}


- (void)testDoesNotMatchNil
{
    assertDoesNotMatch(@"should not match nil", hasItem(equalTo(@"a")), nil);
}


- (void)testProvidesConvenientShortcutForMatchingWithIsEqualTo
{
    assertMatches(@"list contains 'a'",
                  hasItem(@"a"), ([NSSet setWithObjects:@"a", @"b", @"c", nil]));
    assertDoesNotMatch(@"list without 'a'",
                       hasItem(@"a"), ([NSSet setWithObjects:@"b", @"c", nil]));
}


- (void)testDoesNotMatchObjectWithoutEnumerator
{
    assertDoesNotMatch(@"should not match object without enumerator",
                       hasItem(@"a"), [[[NSObject alloc] init] autorelease]);
}


- (void)testMatcherCreationRequiresNonNilArgument
{    
    STAssertThrows(hasItem(nil), @"Should require non-nil argument");
}


- (void)testHasAReadableDescription
{
    assertDescription(@"a collection containing \"a\"", hasItem(@"a"));
}


- (void)testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(hasItem(@"a"), ([NSSet setWithObjects:@"a", @"b", nil]));
}


- (void)testMismatchDescriptionShowsActualArgument
{
    assertMismatchDescription(@"was \"bad\"", hasItem(@"a"), @"bad");
}


- (void)testDescribeMismatch
{
    assertDescribeMismatch(@"was \"bad\"", hasItem(@"a"), @"bad");
}

@end

//--------------------------------------------------------------------------------------------------

@interface IsCollectionContainingItemsTest : AbstractMatcherTest
@end

@implementation IsCollectionContainingItemsTest

- (void)testShouldMatchCollectionContainingAllItems
{
    assertMatches(@"contains all items",
                  (hasItems(equalTo(@"a"), equalTo(@"b"), equalTo(@"c"), nil)),
                  ([NSArray arrayWithObjects:@"a", @"b", @"c", nil]));
}


- (void)testProvidesConvenientShortcutForMatchingWithIsEqualTo
{
    assertMatches(@"contains all items",
                  (hasItems(@"a", @"b", @"c", nil)),
                  ([NSArray arrayWithObjects:@"a", @"b", @"c", nil]));
}


- (void)testShouldMatchCollectionContainingAllItemsInDifferentOrder
{
    assertMatches(@"all items in different order",
                  (hasItems(@"a", @"b", @"c", nil)),
                  ([NSArray arrayWithObjects:@"c", @"b", @"a", nil]));
}


- (void)testShouldMatchCollectionContainingAllItemsPlusExtras
{
    assertMatches(@"all items plus extras",
                  (hasItems(@"a", @"b", @"c", nil)),
                  ([NSArray arrayWithObjects:@"e", @"c", @"b", @"a", @"d", nil]));
}


- (void)testNoMatchIfCollectionDoesntSatisfyAllMatchers
{
    assertDoesNotMatch(@"missing 'a'",
                       (hasItems(equalTo(@"a"), equalTo(@"b"), equalTo(@"c"), nil)),
                       ([NSArray arrayWithObjects:@"e", @"c", @"b", @"d", nil]));
}

- (void)testMatcherCreationRequiresNonNilArgument
{    
    STAssertThrows(hasItems(nil), @"Should require non-nil list");
}


- (void)testHasAReadableDescription
{
    assertDescription(@"(a collection containing \"a\" and a collection containing \"b\")",
                      hasItems(@"a", @"b", nil));
}


- (void)testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(hasItems(@"a", @"b", nil),
                                ([NSSet setWithObjects:@"a", @"b", nil]));
}


- (void)testMismatchDescriptionShowsFirstUnmetMatcherAndActualArgument
{
    assertMismatchDescription(@"a collection containing \"a\" was \"bad\"",
                              hasItems(@"a", @"b", nil), @"bad");
}


- (void)testDescribeMismatch
{
    assertDescribeMismatch(@"a collection containing \"a\" was \"bad\"",
                           hasItems(@"a", @"b", nil), @"bad");
}

@end
