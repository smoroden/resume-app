//
//  ResumePresenter.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation
import UIKit

/// The default presenter for this application. It expects that one `ResumeViewControllerProtocol`
/// handles all the rendering of errors/updates to the resume
class ResumePresenter: ResumePresenterProtocol {
    // MARK: - Properties
    private weak var viewController: ResumeViewControllerProtocol?
    private let repository: ResumeRepositoryProtocol

    /// An easy initalizer for using all the default configuration
    ///
    /// Using the following classes for defaults:
    /// - `ResumeRemoteConfig`
    /// - `ResumeRemoteService`
    /// - `ResumeLocalRepository`
    /// - `ResumeRepository`
    ///
    /// - Parameter viewController: The view controller that is handling the rendering
    convenience init(viewController: ResumeViewControllerProtocol? = nil) {
        let config = ResumeRemoteConfig()
        let remoteService = ResumeRemoteService(config: config)
        let localRepository = ResumeLocalRepository()
        let repository = ResumeRepository(remoteService: remoteService, localRepository: localRepository)
        
        self.init(repository: repository, viewController: viewController)
    }

    /// When you want customize things you can use this initializer to send in the fully
    /// setup repository of your choice
    ///
    /// - Parameters:
    ///   - repository: The repository that handles local and remote resume fetching
    ///   - viewController: The view controller that is handling the rendering
    init(repository: ResumeRepositoryProtocol, viewController: ResumeViewControllerProtocol?) {
        self.viewController = viewController
        self.repository = repository
    }

    func loadData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.repository.get { [weak self] (result) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.sendResult(result)
            }
        }
    }

    func refreshData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.repository.refresh { [weak self] (result) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.sendResult(result)
            }
        }
    }

    /// Sends the result to the view controller to render after getting back on the main thread
    ///
    /// - Parameter result: The result from the repository lookup
    private func sendResult(_ result: Result<Resume>) {
        DispatchQueue.main.async { [weak self] in
            guard
                let strongSelf = self,
                let viewController = strongSelf.viewController
                else {
                    return
            }
            switch result {
            case .success(let resume):
                viewController.render(viewModel: strongSelf.viewModel(from: resume))
            case .error(let error):
                viewController.render(error: error)
            }
        }
    }

    private func viewModel(from resume: Resume) -> ResumeViewModel {
        return ResumeViewModel(resume: resume)
    }
}
