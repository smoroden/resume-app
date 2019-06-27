//
//  ResumeRepositoryProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

typealias ResumeCompletion = (Result<Resume>) -> Void

protocol ResumeRepositoryProtocol {
    /// Get a `Resume` from the repository. If no local resume is found it will attempt
    /// to refresh using a remote source.
    ///
    /// - Parameter completion: A  block that will return a `Result` that either contains
    ///   the `Resume` object or an error if no resume could be found.
    func get(completion: @escaping ResumeCompletion)
    /// Refreshes the resume from the remote source and calls the completion when
    /// it has returned.
    ///
    /// - Parameter completion: A  block that will return a `Result` that either contains
    ///   the `Resume` object or an error if no resume could be found.
    func refresh(completion: @escaping ResumeCompletion)
}
