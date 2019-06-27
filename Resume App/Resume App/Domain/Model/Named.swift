//
//  Named.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-25.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// Named is used to make simple types more type safe.
/// For example if we have a function that takes an email address
/// we don't want to send any String into it but values we know
/// should indeed be an email.
///
/// This is done by using a caseless enum as tag so that it
/// cannot be accidentally instantiated.
/// eg.
///
///     enum EmailTag { }
///
/// Then make a typealias for how you want to actually use the strong type
/// eg.
///
///     typealias Email = Named<EmailTag>
///
/// Now you can use `Email` whenever you need a strong type.
///
/// This could be extended to use other base types other than `String`
/// but that is beyond the scope of this project.
struct Named<T>: Hashable, ExpressibleByStringLiteral {
    var value: String

    init(_ value: String) {
        self.value = value
    }

    init(stringLiteral value: String) {
        self.value = value
    }
}

extension Named: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        value = try container.decode(String.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
