//
//  ConsoleLoggerOutput.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

public final class ConsoleLoggerOutput: LoggerOutput {
    public init() {}
    
    public func write(_ message: String) {
        print(message)
    }
}
