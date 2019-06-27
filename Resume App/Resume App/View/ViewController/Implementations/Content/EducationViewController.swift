//
//  EducationViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// Displays all the education data in the resume.
/// Currently the cells are super basic and there is a lot more info to add.
/// In the interest of time it was kept that way.
class EducationViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let viewModel: EducationViewModel

    // MARK: - Views
    /// If no schools are in the resume this view is shown
    private lazy var emptyView: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.5
        let localized = NSLocalizedString("education.empty.message", comment: "The message to display when no education values are returned")
        label.text = localized
        label.textColor = .white
        label.accessibilityValue = localized
        label.accessibilityIdentifier = "EducationEmptyView"
        label.textAlignment = .center

        return label
    }()

    /// The list of schools when some are present
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "EducationTableView"
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.education
        tableView.tableFooterView = UIView()
        
        return tableView
    }()

    // MARK: - Init
    init(viewModel: EducationViewModel, presenter: ResumePresenterProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

// MARK: - Lifecycle
extension EducationViewController {
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
extension EducationViewController {
    /// Any setup for the view controller iteself
    private func setupViewController() {
        view.backgroundColor = UIColor.education
        title = NSLocalizedString("education.title", comment: "The title of the education page.")
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
        tableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: SchoolTableViewCell.Constants.defaultReuseIdentifier)
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
extension EducationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.Constants.defaultReuseIdentifier, for: indexPath) as! SchoolTableViewCell

        cell.setEducation(viewModel.items[indexPath.row])

        return cell
    }
}
