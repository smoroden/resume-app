//
//  EducationViewModel.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The view model for an education view
struct EducationViewModel {
    let items: [School]

    init(education: [Resume.Education]) {
        items = education.map(School.init)
    }

    /// An individual school or institution 
    struct School {
        let programTitle: String
        let level: String
        let name: String

        init(education: Resume.Education) {
            programTitle = education.title
            level = education.level
            name = education.institute
        }
    }
}
