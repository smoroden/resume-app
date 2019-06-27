//
//  ResumeNavigationViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-25.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// The navigation controller that is the root view controller of the app.
class ResumeNavigationViewController: UINavigationController {
    // MARK: - Properties
    var presenter: ResumePresenterProtocol!
    private var viewModel: ResumeViewModel?

    // MARK: - Views

    /// Shows the user that we are attempting to download a new resume
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()

    init(repository: ResumeRepositoryProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)

        if let repository = repository {
            presenter = ResumePresenter(repository: repository, viewController: self)
        } else {
            presenter = ResumePresenter(viewController: self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
        setEmptyView()
        startActivity()

        presenter.loadData()
    }
}

// MARK: - View Setup
extension ResumeNavigationViewController {
    private func setupController() {
        view.backgroundColor = .white
    }

    /// Set the base view controller to the empty view controller when no data has been downloaded yet.
    private func setEmptyView() {
        let message = NSLocalizedString("empty.message", comment: "The text that displays on an empty view")
        setViewControllers([EmptyViewController(message: message, presenter: presenter)], animated: true)
    }

    /// Start the activity indicator
    private func startActivity() {
        view.addSubview(activityIndicator)

        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - ResumeViewControllerProtocol
extension ResumeNavigationViewController: ResumeViewControllerProtocol {
    func render(viewModel: ResumeViewModel) {
        activityIndicator.stopAnimating()
        self.viewModel = viewModel

        let home = ResumeHomeViewController(viewModel: viewModel, presenter: presenter)
        setViewControllers([home], animated: true)
    }

    func render(error: Error) {
        activityIndicator.stopAnimating()

        if let viewModel = viewModel {
            let home = ResumeHomeViewController(viewModel: viewModel, presenter: presenter)
            setViewControllers([home], animated: false)
            alert(message: error.localizedDescription)
        } else {
            let message = "An error occured: \(error.localizedDescription)"
            setViewControllers([EmptyViewController(message: message, presenter: presenter)], animated: true)
        }

    }

    /// Displays an alert to the user
    ///
    /// - Parameter message: The message to be displayed
    private func alert(message: String) {
        let title = NSLocalizedString("navigation.error.title", comment: "The title of the error alert")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let actionTitle = NSLocalizedString("navigation.error.ok.title", comment: "The error alert ok title")
        let okAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)

        alertController.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            guard
                let strongSelf = self,
                let viewController = strongSelf.topViewController
            else {
                return
            }

            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
