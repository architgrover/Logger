//
//  LoggerLogLevel.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

public enum LoggerLogLevel: String, Sendable {
    case info = "INFO"
    case debug = "DEBUG"
    case error = "ERROR"
    case warning = "WARNING"

    var emoji: String {
        switch self {
        case .info: return "ℹ️"
        case .debug: return "🐞"
        case .error: return "❌"
        case .warning: return "⚠️"
        }
    }
}
