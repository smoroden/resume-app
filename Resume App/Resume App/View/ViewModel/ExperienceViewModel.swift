//
//  ExperienceViewModel.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The view model for a previous experience view
struct ExperienceViewModel {
    let items: [Experience]

    init(experience: [Resume.Experience]) {
        items = experience.map(Experience.init)
    }
    
    /// An individual piece of previous experience
    struct Experience {
        let employer: String
        let description: String

        init(experience: Resume.Experience) {
            employer = experience.employer
            description = experience.description
        }
    }
}
