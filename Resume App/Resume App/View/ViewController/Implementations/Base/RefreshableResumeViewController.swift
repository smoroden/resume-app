//
//  RefreshableResumeViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-25.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation
import UIKit

/// Each view controller in the navigation stack needs to make a refresh button available
/// if we want to keep it there.
/// This class is meant to be inherited from any view controller than will be put onto the stack.
///
/// It handles the creation of the navigation item and the actions/changes surrounding the user tapping it.
class RefreshableResumeViewController: UIViewController {
    // MARK: - Properties
    weak var presenter: ResumePresenterProtocol?

    // MARK: - Views


    /// The activity indicator to replace the refresh button
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.accessibilityIdentifier = "RefreshActivityIndicator"
        activity.accessibilityLabel = NSLocalizedString("global.refreshindicator.accessibility.label", comment: "A refresh is in progress")

        return activity
    }()

    /// The bar button item for the activity indicator
    lazy var activityButton: UIBarButtonItem = {
        return UIBarButtonItem(customView: activityIndicator)
    }()

    /// The refresh bar button item. When tapped it will attempt to refresh the resume
    lazy var refreshButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        barButton.accessibilityIdentifier = "RefreshButton"
        return barButton
    }()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
    }

    // MARK: - View Setup
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = refreshButton
    }

    // MARK: - Actions
    @objc func refresh() {
        guard let presenter = presenter else {
            return
        }
        navigationItem.rightBarButtonItem = activityButton
        activityIndicator.startAnimating()
        presenter.refreshData()
    }
}
