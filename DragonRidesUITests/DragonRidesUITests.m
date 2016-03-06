//
//  DragonRidesUITests.m
//  DragonRidesUITests
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "Warrior.h"

@interface DragonRidesUITests : XCTestCase

@end

@implementation DragonRidesUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// For this test to succeed, Language should be Spanish (es) and Currency EUR
- (void)testTable {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Buscar vuelos"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    XCTAssertEqual(app.tables.cells.count, 1000);

    [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Precio : .EUR9,618.81"].staticTexts[@"Tyria - Ar Noy / Ar Noy - Tyria"] tap];

    [[app.tables containingType:XCUIElementTypeOther identifier:@"Meraxes"].element tap];
    XCTAssertEqual(app.tables.cells.count, 2);

    
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// prior test this method delete the 2 apps, the original qnd the one installed by uiTest
-(void)testWarriorCreation{
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Ajustes"] tap];

    XCUIElementQuery *tablesQuery2 = app.tables;
    XCUIElementQuery *tablesQuery = tablesQuery2;
    [tablesQuery.textFields[@"Name"] tap];
    [[[[tablesQuery2 childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeTextField].element typeText:@"Boris"];
    [tablesQuery.textFields[@"Surname"] tap];
    [[[[tablesQuery2 childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeTextField].element typeText:@"Chirino"];
    [tablesQuery.textFields[@"Date of birth"] tap];
    
    XCUIElementQuery *datePickersQuery = app.datePickers;
    [[datePickersQuery.pickerWheels elementBoundByIndex:0] swipeUp];
    [[datePickersQuery.pickerWheels elementBoundByIndex:1] swipeUp];
    [[datePickersQuery.pickerWheels elementBoundByIndex:2] swipeDown];
    
    [tablesQuery.textFields[@"Currency"] tap];
    
    [app.pickerWheels[@"GBP"] adjustToPickerWheelValue:@"USD"];

    [app.toolbars.buttons[@"OK"] tap];
    [app.navigationBars[@"WarriorDataView"].buttons[@"Guardar"] tap];
    
    //XCTAssertEqual(warrior.name, );
}

@end
