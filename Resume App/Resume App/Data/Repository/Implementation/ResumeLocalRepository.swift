//
//  ResumeLocalRepository.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-23.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import Foundation

/// The default local storage manager for this application
class ResumeLocalRepository: ResumeLocalRepositoryProtocol {
    // MARK: - Properties
    let fileName: String

    // MARK: - Init
    init(fileName: String = Constants.FileName) {
        self.fileName = fileName
    }


    /// Private constant values
    private enum Constants {
        static let FileName = "resume.json"
    }

    // MARK: - ResumeLocalRepositoryProtocol
    func get() throws -> Resume {
        let path = try localPath()

        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let resume = try decoder.decode(Resume.self, from: data)

            return resume
        } catch let error as DecodingError {
            throw ResumeLocalRepositoryError.decodingError(error)
        } catch let error as NSError {
            if error.code == ResumeLocalRepositoryError.FileNotFoundCode {
                throw ResumeLocalRepositoryError.noDataFound
            } else {
                throw error
            }
        }
    }

    func set(resume: Resume?) throws {
        guard let resume = resume else {
            try delete()
            return
        }
        let encoder = JSONEncoder()

        let data = try encoder.encode(resume)
        try data.write(to: try localPath(), options: [.atomic])
    }

    private func delete() throws {
        let fileManager = FileManager.default

        let path = try localPath()
        if fileManager.fileExists(atPath: path.absoluteString) {
            try fileManager.removeItem(at: path)
        }

    }
}

// MARK: - Helper Functions
extension ResumeLocalRepository {
    /// Gets the local path where the resume data is stored
    ///
    /// - Returns: The URL of where the data is/should be
    /// - Throws: ResumeLocalRepositoryError.noDocumentsPath error if for some reason the documents path cannot
    ///           be found
    private func localPath() throws -> URL {
        guard let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ResumeLocalRepositoryError.noDocumentsPath
        }

        return documentsPath.appendingPathComponent(fileName)
    }
}
