//
//  LoggerOutputType.swift
//  Logger
//
//  Created by Bharat Grover on 15/02/25.
//

import Foundation

public enum LoggerOutputType: Sendable {
    case console
    case file(URL)
    case custom(LoggerOutput)
}
