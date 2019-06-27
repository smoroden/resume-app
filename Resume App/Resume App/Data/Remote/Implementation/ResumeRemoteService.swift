//
//  ResumeRemoteService.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The default remote service for this application.
/// It gets a Resume from the configured url on a background thread and
/// returns a `Result<Resume>`
class ResumeRemoteService: NSObject, ResumeRemoteServiceProtocol {
    // MARK: - Properties
    private let config: ResumeRemoteConfigProtocol
    private var completion: ResumeCompletion?

    /// The `URLSession` used to make the requests. Will make each request in the background.
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

    // MARK: - Init

    /// Create a new service that will communicate with the service
    /// as configured by the config object passed in.
    ///
    /// - Parameter config: Everything the service needs to communicate with the API
    required init(config: ResumeRemoteConfigProtocol) {
        self.config = config
    }

    // MARK: - ResumeRemoteServiceProtocol
    func getResume(completion: @escaping ResumeCompletion) {
        self.completion = completion

        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let dataTask = strongSelf.session.dataTask(with: strongSelf.config.url)
            
            dataTask.resume()
        }
    }
}

// MARK: - URLSessionDataDelegate
extension ResumeRemoteService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let decoder = JSONDecoder()
        do {
            let resume = try decoder.decode(Resume.self, from: data)
            completion?(.success(resume))
        } catch let error {
            completion?(.error(error))
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            completion?(.error(error))
        }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let error = error {
            completion?(.error(error))
        }
    }
}
