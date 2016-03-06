//
//  DragonRidesTests.m
//  DragonRidesTests
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebService.h"
#import "FlightsViewController.h"
#import "FlightsView.h"
#import "Warrior.h"
#import "CoreDataStack.h"

@interface DragonRidesTests : XCTestCase

@end

@implementation DragonRidesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testTableView{
    FlightsViewController *viewController = [FlightsViewController new];

    XCTAssert([viewController.view isKindOfClass:[FlightsView class]]);
    XCTAssert([viewController.tableView isKindOfClass:[UITableView class]]);
}

-(void)testExchangeRateWebService{
    XCTestExpectation *expectation = [self expectationWithDescription:@"flickr.people.findByUsername"];
    [[WebService shared] getExchangeRateFromCurrency:@"EUR" toCurrency:@"USD" completion:^(NSNumber *rate, NSError *error) {
        XCTAssertNotNil(rate, "data should not be nil");
        XCTAssertNil(error, "error should be nil");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        NSLog(@"i've waited a long time, getExchangeRateFromCurrency service failed");
    }];
}

-(void)testWarriorCreationWithUI{
    Warrior *warrior = [CoreDataStack getWarriorInContext:[CoreDataStack mainContext]];
    NSLog(@"%@", warrior.name);
    XCTAssertEqualObjects(warrior.name, @"Boris",@"Failed. First execute UI test of warrior creation");
}

@end
