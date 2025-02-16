import XCTest
@testable import Logger

class LoggerTests: XCTestCase {
    func testConsoleLogging() async {
        let mockConsoleOutput = MockConsoleLoggerOutput()
        
        await Logger.configure(LoggerConfiguration(outputTypes: [.custom(mockConsoleOutput)]))
        
        Logger.info("Test console message")
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            XCTFail("Error during sleep: \(error)")
        }
        
        let messages = await mockConsoleOutput.getCapturedMessages()
        
        XCTAssertTrue(messages.contains(where: { $0.contains("Test console message") }), "Console output did not capture the message: Test console message")
    }
    
    func testFileLogging() async {
        let mockFileOutput = MockFileLoggerOutput()
        
        await Logger.configure(LoggerConfiguration(outputTypes: [.custom(mockFileOutput)]))
        
        Logger.info("Test file message")
        
        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)
        } catch {
            XCTFail("Error during sleep: \(error)")
        }
        
        let messages = await mockFileOutput.getCapturedMessages()
        
        XCTAssertTrue(messages.contains(where: { $0.contains("Test file message") }), "File output did not capture the message: Test file message")
    }
    
    func testMultipleOutputs() async {
        let mockConsoleOutput = MockConsoleLoggerOutput()
        let mockFileOutput = MockFileLoggerOutput()
        
        await Logger.configure(LoggerConfiguration(outputTypes: [.custom(mockConsoleOutput), .custom(mockFileOutput)]))
        print("Configured output types: \(await Logger.getConfiguration().outputTypes)")
        
        Logger.info("Test multiple outputs message")
        
        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)
        } catch {
            XCTFail("Error during sleep: \(error)")
        }
        
        let consoleMessages = await mockConsoleOutput.getCapturedMessages()
        let fileMessages = await mockFileOutput.getCapturedMessages()
        
        XCTAssertTrue(consoleMessages.contains(where: { $0.contains("Test multiple outputs message") }), "Console did not capture the message: Test multiple outputs message")
        XCTAssertTrue(fileMessages.contains(where: { $0.contains("Test multiple outputs message") }), "File did not capture the message: Test multiple outputs message")
    }
    
    func testThreadSafety() async {
        let mockConsoleOutput = MockConsoleLoggerOutput()
        
        await Logger.configure(LoggerConfiguration(outputTypes: [.console, .custom(mockConsoleOutput)]))
        
        for i in 0..<10 {
            Task {
                Logger.info("Test thread safety message \(i)")
            }
        }
        
        do {
            try await Task.sleep(nanoseconds: 1_500_000_000)
        } catch {
            XCTFail("Error during sleep: \(error)")
        }
        
        let messages = await mockConsoleOutput.getCapturedMessages()
        XCTAssertEqual(messages.count, 10, "Thread safety test failed")
    }
}
