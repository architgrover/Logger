//
//  FileLoggerOutput.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

import Foundation

public final class FileLoggerOutput: LoggerOutput {
    private let fileURL: URL

    public init(fileURL: URL) {
        self.fileURL = fileURL
    }

    public func write(_ message: String) {
        do {
            let handle = try FileHandle(forWritingTo: fileURL)
            handle.seekToEndOfFile()
            handle.write(message.data(using: .utf8)!)
            handle.write("\n".data(using: .utf8)!)
            handle.closeFile()
        } catch {
            print("Error writing to file: \(error)")
        }
    }
}
