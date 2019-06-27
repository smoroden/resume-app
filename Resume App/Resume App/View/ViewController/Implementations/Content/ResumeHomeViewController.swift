//
//  ResumeHomeViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// The home page of the resume. Contains buttons to access each of the resume's parts.
class ResumeHomeViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let viewModel: ResumeViewModel

    private enum Constants {
        static let shadowRadius: CGFloat = 3
        static let shadowOpacity: Float = 0.5
        static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
    }

    // MARK: - Views
    /// The button to go to the profile page
    lazy var profileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("home.profile.button.title", comment: "The label on the button to go to the profile."), for: .normal)
        button.accessibilityIdentifier = "ProfileButton"
        button.backgroundColor = UIColor.profile
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOffset = Constants.shadowOffset
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = Constants.shadowOpacity

        button.addTarget(self, action: #selector(profileTap), for: .touchUpInside)

        return button
    }()

    /// The button to go to the education page
    lazy var educationButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("home.education.button.title", comment: "The label on the button to go to the eduction page."), for: .normal)
        button.accessibilityIdentifier = "EducationButton"
        button.backgroundColor = UIColor.education
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOffset = Constants.shadowOffset
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = Constants.shadowOpacity

        button.addTarget(self, action: #selector(educationTap), for: .touchUpInside)

        return button
    }()

    /// The button to go to the skills page
    lazy var skillsButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("home.skills.button.title", comment: "The label on the button to go to the skills page."), for: .normal)
        button.accessibilityIdentifier = "SkillsButton"
        button.backgroundColor = UIColor.skills
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOffset = Constants.shadowOffset
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = Constants.shadowOpacity

        button.addTarget(self, action: #selector(skillsTap), for: .touchUpInside)

        return button
    }()

    /// The button to go to the experience page
    lazy var experienceButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("home.experience.button.title", comment: "The label on the button to go to the experience page."), for: .normal)
        button.accessibilityIdentifier = "ExperienceButton"
        button.backgroundColor = UIColor.experience
        button.layer.shadowRadius = Constants.shadowRadius
        button.layer.shadowOffset = Constants.shadowOffset
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = Constants.shadowOpacity

        button.addTarget(self, action: #selector(experienceTap), for: .touchUpInside)

        return button
    }()

    /// The button to go to the expertise page
    lazy var expertiseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("home.expertise.button.title", comment: "The label on the button to go to the expertise page."), for: .normal)
        button.accessibilityIdentifier = "ExpertiseButton"
        button.backgroundColor = UIColor.expertise

        button.addTarget(self, action: #selector(expertiseTap), for: .touchUpInside)

        return button
    }()

    // MARK: - Init
    init(viewModel: ResumeViewModel, presenter: ResumePresenterProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.presenter = presenter
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.fullName
        setupStack()
    }

    // MARK: - View Setup
    private func setupStack() {
        let stackView = UIStackView(arrangedSubviews: [profileButton, experienceButton, educationButton, skillsButton, expertiseButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }

    // MARK: - Actions
    @objc private func profileTap() {
        guard
            let presenter = presenter,
            let navigationController = navigationController
        else {
            print("No presenter in \(#function)")
            return
        }

        navigationController.pushViewController(ProfileViewController(viewModel: viewModel.profile, presenter: presenter), animated: true)
    }

    @objc private func educationTap() {
        guard
            let presenter = presenter,
            let navigationController = navigationController
        else {
            print("No presenter in \(#function)")
            return
        }

        navigationController.pushViewController(EducationViewController(viewModel: viewModel.education, presenter: presenter), animated: true)
    }

    @objc private func skillsTap() {
        guard
            let presenter = presenter,
            let navigationController = navigationController
        else {
                print("No presenter in \(#function)")
                return
        }

        navigationController.pushViewController(SkillsViewController(viewModel: viewModel.skills, presenter: presenter), animated: true)
    }

    @objc private func expertiseTap() {
        guard
            let presenter = presenter,
            let navigationController = navigationController
        else {
                print("No presenter in \(#function)")
                return
        }

        navigationController.pushViewController(ExpertiseViewController(viewModel: viewModel.expertise, presenter: presenter), animated: true)
    }

    @objc private func experienceTap() {
        guard
            let presenter = presenter,
            let navigationController = navigationController
        else {
                print("No presenter in \(#function)")
                return
        }

        navigationController.pushViewController(ExperienceViewController(viewModel: viewModel.experience, presenter: presenter), animated: true)
    }
}

