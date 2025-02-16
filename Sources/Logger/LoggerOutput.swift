//
//  LoggerOutput.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

public protocol LoggerOutput: Sendable {
    func write(_ message: String) async
}
