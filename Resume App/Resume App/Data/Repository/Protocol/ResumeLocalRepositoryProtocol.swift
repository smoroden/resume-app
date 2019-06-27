//
//  ResumeLocalRepositoryProtocol.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// Objects that conform to this protocol are seen as local offline storage for a `Resume` object
protocol ResumeLocalRepositoryProtocol {
    /// Get the locally stored `Resume`
    ///
    /// - Returns: The stored `Resume`
    /// - Throws: A `ResumeLocalRepositoryError` is thrown on error
    func get() throws -> Resume
    /// Save the given resume to local storage. Nil will remove the file
    ///
    /// - Parameter resume: The `Resume` to be saved
    /// - Throws: A `ResumeLocalRepositoryError` is thrown on error
    func set(resume: Resume?) throws
}

/// Errors thrown in rleation to a `ResumeLocalRepositoryProtocol` object.
enum ResumeLocalRepositoryError: Error, Equatable{
    /// The documents path was unable to be found by the system
    case noDocumentsPath
    /// No data was found in local storage
    case noDataFound
    /// The data that was found was unable to be decoded. Takes a `DecodingError`
    case decodingError(_ error: Error)

    /// The error code when a file cannot be found by the system
    static let FileNotFoundCode = 260

    static func == (lhs: ResumeLocalRepositoryError, rhs: ResumeLocalRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.noDocumentsPath, .noDocumentsPath):
            return true
        case (.noDataFound, .noDataFound):
            return true
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError as NSError == rhsError as NSError
        default:
            return false
        }
    }
}

// MARK: - CustomStringConvertible
extension ResumeLocalRepositoryError: CustomStringConvertible {
    var description: String {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
        case .decodingError:
            return NSLocalizedString("localrepository.error.decode", comment: "User friendly error when a decoding issue happened")
        case .noDataFound:
            return NSLocalizedString("localrepository.error.nodata", comment: "User friendly error when no data is found")
        case .noDocumentsPath:
            return NSLocalizedString("localrepository.error.nodocumentspath", comment: "User friend error when the documents path cannot be found")
        }
    }
}
