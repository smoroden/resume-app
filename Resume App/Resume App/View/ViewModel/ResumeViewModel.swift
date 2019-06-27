//
//  ResumeViewModel.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The entire view model as gets sent to a view by the presenter
struct ResumeViewModel {
    let profile: ProfileViewModel
    let education: EducationViewModel
    let experience: ExperienceViewModel
    let expertise: ExpertiseViewModel
    let skills: SkillsViewModel

    /// Convience for getting the full name of a profile
    var fullName: String {
        return profile.fullName
    }

    init(resume: Resume){
        profile = ProfileViewModel(profile: resume.profile)
        education = EducationViewModel(education: resume.education)
        experience = ExperienceViewModel(experience: resume.experience)
        expertise = ExpertiseViewModel(items: resume.expertise)
        skills = SkillsViewModel(items: resume.techSkills)
    }
}
