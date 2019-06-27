//
//  ResumeRemoteServiceProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// A service get a `Resume` object from some remote service.
protocol ResumeRemoteServiceProtocol {
    /// Get a `Resume` from a remote service
    ///
    /// - Parameter completion: Called when the remote service returns. The `Result` contains either
    ///                         a `Resume` obejct or the error that occured.
    func getResume(completion: @escaping ResumeCompletion)
}
