//
//  MockLogStorage.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

@testable import Logger

final class MockLogStorage {
    private var messages: [String] = []
    
    func getMessages() -> [String] {
        return messages
    }
    
    func appendMessage(_ message: String) {
        messages.append(message)
    }
}
