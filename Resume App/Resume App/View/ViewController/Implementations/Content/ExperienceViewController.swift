//
//  ExperienceViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// All the previous experience is listed in this view.
/// Again the cells themselves are very basic but due to time constraints
/// it was kept this way.
class ExperienceViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let viewModel: ExperienceViewModel

    // MARK: - Views

    /// When no previous experience is provided this view is displayed
    private lazy var emptyView: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.5
        let localized = NSLocalizedString("experience.empty.message", comment: "The message to display when no experience values are returned")
        label.text = localized
        label.textColor = .white
        label.accessibilityValue = localized
        label.accessibilityIdentifier = "ExperienceEmptyView"
        label.textAlignment = .center

        return label
    }()

    /// The tableview which displays the previous work experience
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "ExpereinceTableView"
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.experience
        tableView.tableFooterView = UIView()

        return tableView
    }()

    // MARK: - Init
    init(viewModel: ExperienceViewModel, presenter: ResumePresenterProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension ExperienceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()

        if viewModel.items.isEmpty {
            tableView.removeFromSuperview()
            setupEmptyView()
        } else {
            emptyView.removeFromSuperview()
            setupTableView()
        }
    }
}

// MARK: - View Setup
extension ExperienceViewController {
    /// Any setup for the view controller iteself
    private func setupViewController() {
        view.backgroundColor = UIColor.experience
        title = NSLocalizedString("experience.title", comment: "The title of the experience page.")
    }
    private func setupEmptyView() {
        view.addSubview(emptyView)
        constrainEmptyView()
    }

    private func constrainEmptyView() {
        let constraints = [
            emptyView.leftAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leftAnchor, multiplier: 1.0),
            emptyView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(ExperienceTableViewCell.self, forCellReuseIdentifier: ExperienceTableViewCell.Constants.defaultReuseIdentifier)
        tableView.dataSource = self
        constrainTableView()
    }

    private func constrainTableView() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UITableViewDataSource
extension ExperienceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceTableViewCell.Constants.defaultReuseIdentifier, for: indexPath) as! ExperienceTableViewCell

        cell.setExperience(viewModel.items[indexPath.row])

        return cell
    }
}
