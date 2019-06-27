//
//  ResumeRepository.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The main repository for getting and refreshing a `Resume`.
/// This repository needs a `ResumeRemoteServiceProtocol` and a `ResumeLocalRepositoryProtocol`
/// in order to manage a resume.
class ResumeRepository: ResumeRepositoryProtocol {
    // MARK: - Properties
    let remoteService: ResumeRemoteServiceProtocol
    let localRepository: ResumeLocalRepositoryProtocol

    // MARK: - Init
    init(remoteService: ResumeRemoteServiceProtocol, localRepository: ResumeLocalRepositoryProtocol) {
        self.remoteService = remoteService
        self.localRepository = localRepository
    }

    // MARK: - ResumeRepositoryProtocol
    func get(completion: @escaping ResumeCompletion) {
        do {
            // If we get a local resume then we return it
            let resume = try localRepository.get()
            completion(.success(resume))
        } catch ResumeLocalRepositoryError.noDataFound {
            // If there was no local resume then we try to refresh
            print("Attempting to download new resume...")
            refresh(completion: completion)
        } catch ResumeLocalRepositoryError.noDocumentsPath {
            // Something went really wrong
            print("How did this happen?  \(ResumeLocalRepositoryError.noDocumentsPath.localizedDescription)")
            completion(.error(ResumeLocalRepositoryError.noDocumentsPath))
        } catch ResumeLocalRepositoryError.decodingError(let error) {
            print("Decoding error in local resume: \(error.localizedDescription)")
            print("Attempting to download new resume...")
            refresh(completion: completion)
        } catch let error {
            // Any other error we pass along
            completion(.error(error))
        }
    }

    func refresh(completion: @escaping ResumeCompletion) {
        remoteService.getResume { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .error(let error):
                // Just pass along the error to the presenter
                completion(.error(error))
            case .success(let resume):
                do {
                    // We want to save the new resume locally and pass the fresh resume on
                    try strongSelf.localRepository.set(resume: resume)
                    completion(.success(resume))
                } catch let error {
                    // If we get an error when saving the resume we can still display the error
                    completion(.error(error))
                }
            }
        }
    }
}
