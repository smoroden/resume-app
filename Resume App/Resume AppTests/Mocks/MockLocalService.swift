//
//  MockLocalService.swift
//  Resume AppTests
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation
@testable import Resume_App

class MockLocalRepository: ResumeLocalRepositoryProtocol {
    var resume: Resume?

    init(resume: Resume?) {
        self.resume = resume
    }
    
    func get() throws -> Resume {
        guard let resume = resume else {
            throw ResumeLocalRepositoryError.noDataFound
        }

        return resume
    }

    func set(resume: Resume?) throws {
        self.resume = resume
    }
}
