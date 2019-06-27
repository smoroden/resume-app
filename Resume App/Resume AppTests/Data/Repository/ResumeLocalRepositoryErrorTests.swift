//
//  ResumeLocalRepositoryErrorTests.swift
//  Resume AppTests
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import XCTest
@testable import Resume_App

class ResumeLocalRepositoryErrorTests: XCTestCase {

    func testLocalRepositoryError_EquatableTest() {
        let gwt = """
                  Given two LocalRepositoryError's
                  When you check if they are equal
                  Then it returns the proper result
                  """

        let noDocuments = ResumeLocalRepositoryError.noDocumentsPath
        let noData = ResumeLocalRepositoryError.noDataFound
        let decodingErrorOne = ResumeLocalRepositoryError.decodingError(MockDecodingError.errorOne)
        let decodingErrorTwo = ResumeLocalRepositoryError.decodingError(MockDecodingError.errorTwo)

        XCTAssert(noDocuments == ResumeLocalRepositoryError.noDocumentsPath, gwt)
        XCTAssert(noData == ResumeLocalRepositoryError.noDataFound, gwt)
        XCTAssert(decodingErrorOne == ResumeLocalRepositoryError.decodingError(MockDecodingError.errorOne), gwt)
        XCTAssertFalse(noDocuments == noData, gwt)
        XCTAssertFalse(noDocuments == decodingErrorOne, gwt)
        XCTAssertFalse(decodingErrorOne == decodingErrorTwo, gwt)
    }

}
