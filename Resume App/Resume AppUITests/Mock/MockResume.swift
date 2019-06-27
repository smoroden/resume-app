//
//  MockResume.swift
//  Resume AppUITests
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

struct Mock {
    static let resume1: Resume = {
        let skills: [Skill] = ["Skill1"]
        let expertise: [Expertise] = ["Expertise1"]
        let experience = Resume.Experience.init(title: "Experience Title", employer: "Employer", timeframe: "Timeframe", description: "Experience Description")
        let profile = Resume.Profile.init(firstName: "First", lastName: "Last", title: "Title", phone: "Phone", email: "email@email.com", photo: nil, web: ["test.com"], description: "Profile Description")
        let education = Resume.Education.init(level: "Level1", title: "Education Title", institute: "Institute", location: "Location", year: "2018", honours: nil)

        return Resume(profile: profile, techSkills: skills, expertise: expertise, experience: [experience], education: [education])
    }()

    static let resume2: Resume = {
        let skills: [Skill] = ["Skill2", "Skill3"]
        let expertise: [Expertise] = ["Expertise2", "Expertise3"]
        let experience = Resume.Experience.init(title: "Experience Title 2", employer: "Employer 2", timeframe: "Timeframe 2", description: "Experience Description 2")
        let profile = Resume.Profile.init(firstName: "First2", lastName: "Last2", title: "Title2", phone: "Phone2", email: "email2@email.com", photo: nil, web: ["test2.com"], description: "Profile Description 2")
        let education = Resume.Education.init(level: "Level2", title: "Education Title 2", institute: "Institute 2", location: "Location 2", year: "2019", honours: nil)

        return Resume(profile: profile, techSkills: skills, expertise: expertise, experience: [experience], education: [education])
    }()
}
