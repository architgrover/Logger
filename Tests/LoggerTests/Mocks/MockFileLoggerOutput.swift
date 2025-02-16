//
//  MockFileLoggerOutput.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

@testable import Logger

final actor MockFileLoggerOutput: LoggerOutput {
    private let logStorage = MockLogStorage()

    func write(_ message: String) async {
        logStorage.appendMessage(message)
    }
    
    func getCapturedMessages() -> [String] {
        return logStorage.getMessages()
    }
}
