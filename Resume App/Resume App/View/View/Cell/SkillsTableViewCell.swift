//
//  SkillsTableViewCell.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-25.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

/// The table view cell for all the skills items
class SkillsTableViewCell: UITableViewCell {
    /// A neat container for constants in this class
    enum Constants {
        static let defaultReuseIdentifier = "SkillsCellIdentifier"
    }

    // MARK: - Init
    public required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupCell()
        setupTextLabel()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupCell()
        setupTextLabel()
    }

    // MARK: - View Setup

    /// Update the cell to display the contents of a new `Skill` object.
    ///
    /// - Parameter school: The object to use to update the cell
    func setSkill(_ skill: String) {
        textLabel?.text = skill
        accessibilityLabel = NSLocalizedString("skillcell.accessibility.label", comment: "The accessibility label for a skill cell")
        accessibilityValue = skill
    }

    /// Anything setup to do with the cell iteself
    private func setupCell() {
        backgroundColor = UIColor.skills
    }

    /// Any setup to do with the textLabel
    private func setupTextLabel() {
        textLabel?.textColor = .white
        textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        textLabel?.numberOfLines = 2
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.minimumScaleFactor = 0.5
    }
}
