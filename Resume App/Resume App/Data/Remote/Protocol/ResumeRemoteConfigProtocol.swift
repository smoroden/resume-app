//
//  ResumeRemoteConfigProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// An object used to help configure the remote resume service
protocol ResumeRemoteConfigProtocol {
    /// The url where the remote resume is stored
    var url: URL { get }
}
