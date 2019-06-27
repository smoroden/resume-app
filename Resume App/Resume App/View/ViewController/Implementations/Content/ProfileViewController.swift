//
//  ProfileViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// This view displays all the profile information of the resume.
/// I didn't have time to get the image in there yet.
class ProfileViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let viewModel: ProfileViewModel

    // MARK: - Views

    /// The full name of the resume
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = viewModel.fullName
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.accessibilityLabel = NSLocalizedString("profile.fullname", comment: "The full name in the profile")
        label.accessibilityValue = viewModel.fullName
        label.accessibilityIdentifier = "ProfileFullNameLabel"
        label.textAlignment = .center
        label.textColor = .white

        return label
    }()

    /// The email provided by the resume
    private lazy var emailTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        let localized = NSLocalizedString("profile.email.label", comment: "The email of the profile")
        textView.text = String(format: localized, viewModel.email)
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        textView.accessibilityLabel = NSLocalizedString("profile.email.accessibility.label", comment: "Accessibility label for the email on the profile page")
        textView.accessibilityValue = viewModel.email
        textView.accessibilityIdentifier = "ProfileEmailTextView"
        textView.isScrollEnabled = false
        textView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 100), for: .vertical)
        textView.backgroundColor = UIColor.profile
        textView.textColor = .white

        return textView
    }()

    /// A header for the website section
    private lazy var webHeader: UILabel = {
        let header = UILabel(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        header.text = NSLocalizedString("profile.web.header.title", comment: "The header for the list of websites")
        header.textColor = .white

        return header
    }()

    /// The entire web section
    private lazy var webStack: UIStackView? = {
        guard !viewModel.webLinks.isEmpty else {
            return nil
        }

        var views = [UIView()]
        views.append(webHeader)
        views.append(contentsOf: webButtons())

        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.accessibilityIdentifier = "ProfileWebsiteStackView"
        stackView.accessibilityLabel = NSLocalizedString("profile.web.stack.accessibility.label", comment: "Accessibility label for the list of websites")

        return stackView
    }()

    /// The header for the description section
    private lazy var descriptionHeader: UILabel = {
        let header = UILabel(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        header.text = NSLocalizedString("profile.description.header.title", comment: "The header for the description")
        header.textColor = .white

        return header
    }()

    /// The entire description section
    private lazy var descriptionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionHeader, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.accessibilityIdentifier = "ProfileDescriptionStackView"
        return stackView
    }()

    /// The label that contains the description of the resume
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = viewModel.description
        descriptionLabel.accessibilityValue = viewModel.description
        descriptionLabel.accessibilityIdentifier = "ProfileDescriptionLabel"
        descriptionLabel.accessibilityLabel = NSLocalizedString("profile.description.accessibility.label", comment: "Accessibility label for the profile description")
        descriptionLabel.textColor = .white

        return descriptionLabel
    }()

    /// The phone number from the resume
    private lazy var phoneTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        let localized = NSLocalizedString("profile.phone.label", comment: "The phone number of the profile")
        textView.text = String(format: localized, viewModel.phone)
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        textView.accessibilityLabel = NSLocalizedString("profile.email.accessibility.label", comment: "Accessibility label for the phone number on the profile page")
        textView.accessibilityValue = viewModel.phone
        textView.accessibilityIdentifier = "ProfileEmailTextView"
        textView.isScrollEnabled = false
        textView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 100), for: .vertical)
        textView.backgroundColor = UIColor.profile
        textView.textColor = .white

        return textView
    }()

    /// The stack view that contains the name, email and phone sections.
    private lazy var personalInfoStack: UIStackView = {
        let personalInfoStack = UIStackView(arrangedSubviews: [nameLabel, emailTextView, phoneTextView])
        personalInfoStack.translatesAutoresizingMaskIntoConstraints = false
        personalInfoStack.axis = .vertical
        personalInfoStack.distribution = .fillProportionally
        personalInfoStack.alignment = .fill

        return personalInfoStack
    }()

    /// The stack view that contains the description and web sections.
    private lazy var additionalInfoStack: UIStackView = {
        var views: [UIView] = []
        views.append(descriptionStack)
        if let webStack = webStack {
            views.append(webStack)
        }
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill

        return stackView
    }()

    /// The scroll view the content is embeded in.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Init
    init(viewModel: ProfileViewModel, presenter: ResumePresenterProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

// MARK: - Lifecycle
extension ProfileViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        setupContent()
    }
}

// MARK: - View Setup
extension ProfileViewController {
    /// Setup the content of the view controller
    private func setupContent() {
        view.addSubview(scrollView)
        constrainScrollView()

        scrollView.addSubview(personalInfoStack)
        scrollView.addSubview(additionalInfoStack)
        constrainPersonalStack()
        constrainAdditionalStack()
    }

    /// Anything that needs to be set up in the view controller itself belongs here
    private func setupViewController() {
        view.backgroundColor = UIColor.profile
        title = NSLocalizedString("profile.title", comment: "The title of the profile screen.")
    }

    private func constrainScrollView() {
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func constrainAdditionalStack() {
        let constraints = [
            additionalInfoStack.topAnchor.constraint(equalToSystemSpacingBelow: personalInfoStack.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0),
            additionalInfoStack.leftAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leftAnchor, multiplier: 1.0),
            additionalInfoStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            additionalInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func constrainPersonalStack() {
        let constraints = [
            personalInfoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            personalInfoStack.leftAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leftAnchor, multiplier: 1.0),
            personalInfoStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            personalInfoStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    /// Creates an array of buttons for the websites provided in the profile
    ///
    /// - Returns: An array of buttons that navigate to the website specified
    private func webButtons() -> [UIButton] {
        var buttons: [UIButton] = []

        for (index, website) in viewModel.webLinks.enumerated() {
            let button = UIButton(frame: .zero)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(website, for: .normal)
            button.backgroundColor = .clear
            button.accessibilityTraits = .link
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.contentHorizontalAlignment = .leading
            button.titleLabel?.minimumScaleFactor = 0.5
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            button.accessibilityIdentifier = "ProfileButton-\(index)"

            button.addTarget(self, action: #selector(openUrl(sender:)), for: .touchUpInside)

            buttons.append(button)
        }

        return buttons
    }
}

// MARK: - Actions
extension ProfileViewController {
    /// Open the website from the profile externally
    ///
    /// - Parameter sender: The button that sent the action
    @objc private func openUrl(sender: UIButton) {
        guard
            sender.tag <= viewModel.webLinks.endIndex,
            sender.tag >= viewModel.webLinks.startIndex,
            let url = URL(string: viewModel.webLinks[sender.tag]) else {
                return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
