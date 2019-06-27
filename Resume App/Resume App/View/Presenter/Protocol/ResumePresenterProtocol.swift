//
//  ResumePresenterProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The presenter for a view controller that handles rendering the resume
protocol ResumePresenterProtocol: class {
    /// Get the local data from the repository. This may get the locally stored
    /// version if one exists.
    func loadData()
    /// Explicitly refresh the resume from the repository.
    func refreshData()
}
