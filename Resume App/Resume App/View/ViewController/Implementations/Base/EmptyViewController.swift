//
//  EmptyViewController.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// A view controller that is displayed when no resume exists locally
///
/// Pass in a message to be displayed to the user
class EmptyViewController: RefreshableResumeViewController {
    // MARK: - Properties
    private let message: String

    // MARK: - Views

    /// The message label to be shown to the user
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.accessibilityLabel = "EmptyViewMessageText"
        label.font = UIFont.systemFont(ofSize: 25, weight: .light)
        label.numberOfLines = 3
        label.textAlignment = .center

        return label
    }()
    
    // MARK: - Init
    init(message: String, presenter: ResumePresenterProtocol) {
        self.message = message
        super.init(nibName: nil, bundle: nil)

        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        view.addSubview(messageLabel)
        constrainMessageLabel()
    }

    // MARK: - Setup Views
    private func constrainMessageLabel() {
        let constraints = [
            messageLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            messageLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
