//
//  Result.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// Used by calls that may or may not return data. The Result object needs
/// to be given its type.
enum Result<T> {
    /// If the call was a success return the value received
    case success(_ value: T)
    /// If an error occured return it
    case error(_ error: Error)
}
