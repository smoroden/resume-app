//
//  SkillsViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// The list of all the skills in the resume.
/// As with some of the other views the cells are basic (but so is the underlying data)
/// This would be something to improve with maybe links to github projects or something
/// that demonstrates the skill
class SkillsViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let viewModel: SkillsViewModel

    // MARK: - Views

    /// When no skills are provided this view is displayed
    private lazy var emptyView: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.5
        let localized = NSLocalizedString("skills.empty.message", comment: "The message to display when no skill values are returned")
        label.text = localized
        label.textColor = .white
        label.accessibilityValue = localized
        label.accessibilityIdentifier = "SkillsEmptyView"
        label.textAlignment = .center

        return label
    }()

    /// The tableview which displays the previous work experience
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "SkillsTableView"
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.skills
        tableView.tableFooterView = UIView()

        return tableView
    }()

    // MARK: - Init

    init(viewModel: SkillsViewModel, presenter: ResumePresenterProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Lifecycle
extension SkillsViewController {
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
extension SkillsViewController {
    /// Any setup for the view controller iteself
    private func setupViewController() {
        view.backgroundColor = UIColor.experience
        title = NSLocalizedString("skills.title", comment: "The title of the skills page.")
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
        tableView.register(SkillsTableViewCell.self, forCellReuseIdentifier: SkillsTableViewCell.Constants.defaultReuseIdentifier)
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
extension SkillsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.Constants.defaultReuseIdentifier, for: indexPath) as! SkillsTableViewCell

        cell.setSkill(viewModel.items[indexPath.row])

        return cell
    }
}
