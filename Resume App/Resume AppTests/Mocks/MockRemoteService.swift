//
//  MockRemoteService.swift
//  Resume AppTests
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation
@testable import Resume_App

class MockSuccessfulRemoteService: ResumeRemoteServiceProtocol {
    let resume: Resume

    init(resume: Resume) {
        self.resume = resume
    }
    
    func getResume(completion: @escaping ResumeCompletion) {
        completion(.success(resume))
    }
}

class MockErrorRemoteService: ResumeRemoteServiceProtocol {
    let error: Error
    
    init(error: Error) {
        self.error = error
    }

    func getResume(completion: @escaping ResumeCompletion) {
        completion(.error(error))
    }
}

enum MockRemoteError: Error {
    case noDataReturned
}
