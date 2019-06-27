//
//  Resume_AppUITests.swift
//  Resume AppUITests
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import XCTest

/*
 These are a little simple but I'm not sure they need to be more complicated.
 UI testing is new for me. The biggest questions not answered due to time
 is how to better handle getting the app into error states during these tests.
*/
class Resume_AppUITests: XCTestCase {
    var resume: Resume!
    var app: XCUIApplication!
    let local = ResumeLocalRepository()

    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchArguments = ["--uitesting"]
        app.launch()
    }

    override func tearDown() {
    }

    func testExpertiseView() {
        let gwt = """
                  Given navigating to the expertise view
                  When Mock.resume2 is loaded
                  Then five cells should be present
                  """
        app.buttons["ExpertiseButton"].tap()

        let givenCount = app.tables["ExpertiseTableView"].cells.matching(identifier: "Expertise").count
        let expectedCount = 2

        XCTAssert(givenCount == expectedCount, gwt)
    }

    func testSkillsView() {
        let gwt = """
                  Given navigating to the skills view
                  When Mock.resume2 is loaded
                  Then two cells should be present
                  """
        app/*@START_MENU_TOKEN@*/.buttons["SkillsButton"]/*[[".buttons[\"Skills\"]",".buttons[\"SkillsButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let givenCount = app.tables["SkillsTableView"].cells.matching(identifier: "Skill").count
        let expectedCount = 2

        XCTAssert(givenCount == expectedCount, gwt)
    }

    func testEducationView() {
        let gwt = """
                  Given navigating to the education view
                  When Mock.resume2 is loaded
                  Then two cells should be present
                  """

        app.buttons["EducationButton"].tap()
        let givenCount = app.tables["EducationTableView"].cells.matching(identifier: "School").count
        let expectedCount = 1

        XCTAssert(givenCount == expectedCount, gwt)
    }

    func testExperienceView() {
        let gwt = """
                  Given navigating to the experience view
                  When Mock.resume2 is loaded
                  Then two cells should be present
                  """
        app.buttons["ExperienceButton"].tap()
        let givenCount = app.tables["ExpereinceTableView"].cells.matching(identifier: "Workplace").count
        let expectedCount = 1

        XCTAssert(givenCount == expectedCount, gwt)
    }

    func testProfileView() {
        let gwt = """
                  Given navigating to the profile view
                  When Mock.resume2 is loaded
                  Then all details should be present
                  """

        let app = XCUIApplication()
        app.buttons["ProfileButton"].tap()

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements

        let emailViewExists = scrollViewsQuery.otherElements.containing(.staticText, identifier:"ProfileFullNameLabel").children(matching: .textView).matching(identifier: "ProfileEmailTextView").element.exists

        let descriptionStackViewExists = elementsQuery.otherElements["ProfileDescriptionStackView"].children(matching: .staticText).matching(identifier: "Description").element.exists

        XCTAssert(elementsQuery.otherElements["ProfileWebsiteStackView"].exists, gwt)
        XCTAssert(elementsQuery.staticTexts["ProfileFullNameLabel"].exists, gwt)
        XCTAssert(elementsQuery.textViews.containing(.link, identifier:"email2@email.com").element.exists, gwt)
        XCTAssert(emailViewExists, gwt)
        XCTAssert(descriptionStackViewExists, gwt)
    }

    func testRefreshReturnsToHome() {
        let gwt = """
                  Given navigating to the eperience view
                  When the resume is refreshed
                  Then the app should be back on the home screen
                  """
        app.buttons["ExperienceButton"].tap()
        app.navigationBars["Previous Experience"].buttons["RefreshButton"].tap()

        XCTAssert(app.buttons["ProfileButton"].waitForExistence(timeout: 5), gwt)
    }

    // Need more tests for error and empty states

}
