//
//  ResumeViewControllerProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-24.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation
import UIKit
/// An object that conforms to this protocol is used by the presenter in
/// order for the `Resume` object to be rendered.
protocol ResumeViewControllerProtocol: class {
    /// Display the resume as the view controller sees fit
    ///
    /// - Parameter resume: The resume to be displayed
    func render(viewModel: ResumeViewModel)
    /// Display the error that occured when loading or refreshing
    /// the resume.
    ///
    /// - Parameter error: The error that occured
    func render(error: Error)
}
