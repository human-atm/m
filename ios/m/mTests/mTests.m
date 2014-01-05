//
//  mTests.m
//  mTests
//
//  Created by Andrew Rasmussen on 1/4/14.
//  Copyright (c) 2014 42 Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface mTests : XCTestCase

@end

@implementation mTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
