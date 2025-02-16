//
//  LoggerConfiguration.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

public struct LoggerConfiguration: Sendable{
    public var isEnabled: Bool
    public var dateFormat: String
    public var logLevels: [LoggerLogLevel]
    public var outputTypes: [LoggerOutputType]

    public init(
        isEnabled: Bool = true,
        dateFormat: String = "yyyy-MM-dd",
        logLevels: [LoggerLogLevel] = [.info],
        outputTypes: [LoggerOutputType] = [.console]
    ) {
        self.isEnabled = isEnabled
        self.logLevels = logLevels
        self.dateFormat = dateFormat
        self.outputTypes = outputTypes
    }
    
    public static let `default` = LoggerConfiguration(
        isEnabled: true,
        dateFormat: "yyyy-MM-dd HH:mm:ss.SSS",
        logLevels: [
            .debug,
            .info,
            .warning,
            .error
        ]
    )
}
