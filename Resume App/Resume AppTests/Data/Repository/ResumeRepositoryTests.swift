//
//  ResumeRepositoryTests.swift
//  Resume AppTests
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import XCTest
@testable import Resume_App

class ResumeRepositoryTests: XCTestCase {
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryGetResume_LocalHasResumeTest() {
        let gwt = """
                  Given ResumeRepository get resume
                  When it has a local Resume object
                  Then it returns that local resume object
                  """
        let remote = MockErrorRemoteService(error: MockRemoteError.noDataReturned)
        let local = MockLocalRepository(resume: Mock.resume1)

        let repository = ResumeRepository(remoteService: remote, localRepository: local)

        repository.get { (result) in
            switch result {
            case .success(let resume):
                XCTAssert(resume == Mock.resume1, gwt)
            case .error:
                XCTAssert(false, gwt)
            }
        }
    }

    func testRepositoryGetResume_LocalHasNoResume_RemoteHasResumeTest() {
        let gwt = """
                  Given ResumeRepository get resume
                  When it does not have a local Resume object
                  And the remote has a resume
                  Then it returns the remote resume object
                  """
        let remote = MockSuccessfulRemoteService(resume: Mock.resume2)
        let local = MockLocalRepository(resume: nil)

        let repository = ResumeRepository(remoteService: remote, localRepository: local)

        repository.get { (result) in
            switch result {
            case .success(let resume):
                XCTAssert(resume == Mock.resume2, gwt)
            case .error:
                XCTAssert(false, gwt)
            }
        }
    }

    func testRepositoryGetResume_LocalHasNoResume_RemoteErrorsTest() {
        let gwt = """
                  Given ResumeRepository get resume
                  When it does not have a local Resume object
                  And the remote errors
                  Then it returns an error result
                  """

        let expected = MockRemoteError.noDataReturned
        let remote = MockErrorRemoteService(error: expected)
        let local = MockLocalRepository(resume: nil)

        let repository = ResumeRepository(remoteService: remote, localRepository: local)

        repository.get { (result) in
            switch result {
            case .success:
                XCTAssert(false, gwt)
            case .error(let error):
                guard let given = error as? MockRemoteError else {
                    XCTAssert(false, gwt)
                    return
                }
                XCTAssert(given == expected, gwt)
            }
        }
    }

    func testRepositoryRefreshResume_RemoteSuccessfulTest() {
        let gwt = """
                  Given ResumeRepository refresh resume
                  When remote is successful
                  Then it returns a different resume
                  """

        let expected = Mock.resume2
        let remote = MockSuccessfulRemoteService(resume: expected)
        let local = MockLocalRepository(resume: Mock.resume1)

        let repository = ResumeRepository(remoteService: remote, localRepository: local)

        repository.refresh { (result) in
            switch result {
            case .success(let given):
                XCTAssert(given == expected, gwt)
            case .error:
                XCTAssert(false, gwt)
            }
        }
    }

    func testRepositoryRefreshResume_RemoteFailsTest() {
        let gwt = """
                  Given ResumeRepository refresh resume
                  When remote is successful
                  Then it returns a different resume
                  """

        let expected = MockRemoteError.noDataReturned
        let remote = MockErrorRemoteService(error: expected)
        let local = MockLocalRepository(resume: Mock.resume1)

        let repository = ResumeRepository(remoteService: remote, localRepository: local)

        repository.refresh { (result) in
            switch result {
            case .success:
                XCTAssert(false, gwt)
            case .error(let error):
                guard let given = error as? MockRemoteError else {
                    XCTAssert(false, gwt)
                    return
                }
                XCTAssert(given == expected, gwt)
            }
        }
    }
}
