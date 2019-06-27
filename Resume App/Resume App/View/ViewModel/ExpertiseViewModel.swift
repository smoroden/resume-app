//
//  ExpertiseViewModel.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-26.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The view model for an Expertise view
struct ExpertiseViewModel {
    let items: [String]

    init(items: [Expertise]) {
        self.items = items.map({ $0.value })
    }

    init(items: [String]) {
        self.items = items
    }
}
