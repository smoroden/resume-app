//
//  ResumeRemoteConfig.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The default configuration for this application.
/// Gets a JSON payload from a private gist.
struct ResumeRemoteConfig: ResumeRemoteConfigProtocol {
    var url: URL {
        return URL(string :"https://gist.githubusercontent.com/smoroden/840e8b2ba32dedf4b8e973d140bd3282/raw/cv.json")!
    }
}
