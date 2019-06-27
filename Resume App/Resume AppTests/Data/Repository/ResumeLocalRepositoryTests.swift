//
//  ResumeLocalRepositoryTests.swift
//  Resume AppTests
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import XCTest
@testable import Resume_App

class ResumeLocalRepositoryTests: XCTestCase {
    let local = ResumeLocalRepository(fileName: "test_resume.json")
    override func setUp() {
        try! local.set(resume: Mock.resume1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResumeLocalRepository_GetResumeSuccessfulTest() {
        let gwt = """
                  Given ResumeLocalRepository get resume
                  When it has a local file
                  Then it returns that local resume object
                  """

        let expected = Mock.resume1

        do {
            let given = try local.get()
            XCTAssert(given == expected, gwt)
        } catch {
            XCTAssert(false, gwt)
        }
    }

    func testResumeLocalRepository_GetResumeNoFileExistsTest() {
        let gwt = """
                  Given ResumeLocalRepository get resume
                  When it does not a local file
                  Then it throws ResumeLocalRepositoryError.noDataFound
                  """
        let local = ResumeLocalRepository(fileName: "does_not_exist.json")

        let expected = ResumeLocalRepositoryError.noDataFound

        do {
            _ = try local.get()
            XCTAssert(false, gwt)
        } catch let error {
            guard let given = error as? ResumeLocalRepositoryError else {
                XCTAssert(false, gwt)
                return
            }

            XCTAssert(given == expected, gwt)
        }
    }

    func testResumeLocalRepository_SetResumeTest() {
        let gwt = """
                  Given ResumeLocalRepository get resume
                  When it does not a local file
                  Then it throws ResumeLocalRepositoryError.noDataFound
                  """
        let local = ResumeLocalRepository()
        let expected = Mock.resume2

        do {
            try local.set(resume: Mock.resume2)
            let given = try local.get()

            XCTAssert(given == expected, gwt)
        } catch {
            XCTAssert(false, gwt)
        }
    }
}
