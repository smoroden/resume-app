//
//  ExperienceTableViewCell.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-25.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// The table view cell for the work experience items
class ExperienceTableViewCell: UITableViewCell {
    /// A neat container for constants in this class
    enum Constants {
        static let defaultReuseIdentifier = "ExperienceCellIdentifier"
    }

    // MARK: - Init
    public required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupCell()
        setupDetailTextLabel()
        setupTextLabel()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupCell()
        setupDetailTextLabel()
        setupTextLabel()
    }

    // MARK: - View Setup

    /// Update the cell to display the contents of a new `Resume.Experience` object.
    ///
    /// - Parameter school: The object to use to update the cell
    func setExperience(_ workplace: ExperienceViewModel.Experience) {
        textLabel?.text = workplace.employer
        detailTextLabel?.text = workplace.description
        accessibilityLabel = NSLocalizedString("experiencecell.accessibility.label", comment: "The accessibility label for a experience cell")
        accessibilityValue = "\(workplace.employer). \(workplace.description)"
    }

    /// Anything setup to do with the cell iteself
    private func setupCell() {
        backgroundColor = UIColor.experience
    }

    /// Any setup to do with the textLabel
    private func setupTextLabel() {
        textLabel?.textColor = .white
        textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        textLabel?.numberOfLines = 2
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.minimumScaleFactor = 0.5
    }

    /// Any setup to do with the detailTextLabel
    private func setupDetailTextLabel() {
        detailTextLabel?.textColor = .white
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
    }
}
