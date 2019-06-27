//
//  ProfileViewModel.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The view model for a profile view
struct ProfileViewModel {
    let firstName: String
    let lastName: String
    let email: String
    let webLinks: [String]
    let description: String
    let phone: String

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    init(profile: Resume.Profile) {
        firstName = profile.firstName
        lastName = profile.lastName
        email = profile.email
        webLinks = profile.web
        description = profile.description
        phone = profile.phone
    }
}
