//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by zari on 26/10/2021.
//

import XCTest

class ToDoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.scrollViews.otherElements.buttons["Add 1st ToDo!"].tap()
        
        app.tables.textFields["Write something here..."].tap()
        app.tables.textFields["Write something here..."].typeText("New ToDo")
        app.toolbars["Toolbar"].buttons["Close"].tap()
        app.tables.buttons["Medium"].tap()
        app.tables.buttons["Select category"].tap()
        app.tables.switches["Shopping"].tap()
        app.buttons["Add"].tap()
        
        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Edit"].tap()
        app.tables.buttons["Delete "].tap()
        app.tables.buttons["Delete"].tap()
        app.alerts["Are You sure ?"].scrollViews.otherElements.buttons["Delete"].tap()
        
        
        app.scrollViews.otherElements.buttons["Add 1st ToDo!"].tap()
        app.tables.textFields["Write something here..."].tap()
        app.tables.textFields["Write something here..."].typeText("New ToDo")
        app.toolbars["Toolbar"].buttons["Close"].tap()
        app.tables.buttons["Medium"].tap()
        app.tables.buttons["Select category"].tap()
        app.tables.switches["Shopping"].tap()
        app.buttons["Add"].tap()
        
        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Add"].tap()
        app.tables.cells["Write something here..."].children(matching: .other).element(boundBy: 0).tap()
        app.tables.textFields["Write something here..."].typeText("New ToDo")
        app.toolbars["Toolbar"].buttons["Close"].tap()
        app.tables.buttons["Medium"].tap()
        app.tables.buttons["Select category"].tap()
        app.tables.switches["Work"].tap()
        app.buttons["Add"].tap()
        
        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Done"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
