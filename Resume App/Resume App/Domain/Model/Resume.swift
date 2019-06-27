//
//  Resume.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// A complete resume as coming back from the API
struct Resume: Codable, Hashable {
    let profile: Profile
    let techSkills: [Skill]
    let expertise: [Expertise]
    let experience: [Experience]
    let education: [Education]

    /// Contains personal information
    struct Profile: Codable, Hashable {
        let firstName: String
        let lastName: String
        let title: String
        let phone: String
        let email: String
        let photo: String?
        let web: [String]
        let description: String
    }

    /// Work and/or relevant experience
    struct Experience: Codable, Hashable {
        let title: String
        let employer: String
        let timeframe: String
        let description: String
    }

    /// Schooling, programs, certificates etc.
    struct Education: Codable, Hashable {
        let level: String
        let title: String
        let institute: String
        let location: String
        let year: String
        let honours: String?
    }
}

enum SkillTag { }
typealias Skill = Named<SkillTag>

enum ExpertiseTag { }
typealias Expertise = Named<ExpertiseTag>


