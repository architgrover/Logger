// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public actor Logger {
    private static var shared = Logger()
    private var outputs: [LoggerOutput] = []
    private var _configuration: LoggerConfiguration = .default
    
    private func configure(_ configuration: LoggerConfiguration) {
        _configuration = configuration
        configureOutputs(for: configuration)
    }
    
    private func log(_ message: String, level: LoggerLogLevel, file: String = #file, line: Int = #line, function: String = #function) async {
        guard _configuration.isEnabled, _configuration.logLevels.contains(level) else { return }
        let fileName = (file as NSString).lastPathComponent
        let logMessage = "\(await Logger.timestamp()) [\(level.rawValue)] \(fileName):\(line) \(function) - \(level.emoji) \(message)"
        for output in outputs {
            await output.write(logMessage)
        }
    }
    
    private static func timestamp() async -> String {
        let formatter = DateFormatter()
        let config = await Logger.getConfiguration()
        formatter.dateFormat = config.dateFormat
        return formatter.string(from: Date())
    }
    
    private func setConfiguration(_ configuration: LoggerConfiguration) {
        _configuration = configuration
        configureOutputs(for: configuration)
    }
    
    private func configureOutputs(for configuration: LoggerConfiguration) {
        outputs = configuration.outputTypes.map { outputType in
            switch outputType {
            case .console:
                return ConsoleLoggerOutput()
            case .file(let url):
                return FileLoggerOutput(fileURL: url)
            case .custom(let customOutput):
                return customOutput
            }
        }
    }
}

// Public API
extension Logger {
    public static func log(_ message: String, level: LoggerLogLevel = .info, file: String = #file, line: Int = #line, function: String = #function) {
        Task {
            await shared.log(message, level: level, file: file, line: line, function: function)
        }
    }
    
    public static func info(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        Task {
            await shared.log(message, level: .info, file: file, line: line, function: function)
        }
    }
    
    public static func debug(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        Task {
            await shared.log(message, level: .debug, file: file, line: line, function: function)
        }
    }
    
    public static func warning(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        Task {
            await shared.log(message, level: .warning, file: file, line: line, function: function)
        }
    }
    
    public static func error(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        Task {
            await shared.log(message, level: .error, file: file, line: line, function: function)
        }
    }
    
    public static func configure(_ configuration: LoggerConfiguration) async {
        await shared.configure(configuration)
    }
    
    public static func getConfiguration() async -> LoggerConfiguration {
        return await shared._configuration
    }
}
