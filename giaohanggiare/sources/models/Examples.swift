//
//  Examples.swift
//  giaohanggiare
//
//  Created by tran.quoc.quan on 3/20/18.
//  Copyright © 2018 Quan Tran. All rights reserved.
//

import UIKit
import Foundation

//protocol Person {
//    var firstName: String {get set}
//    var lastName: String {get set}
//    var birthDate: Date {get set}
//    var profession: String {get}
//    init(firstName: String, lastName: String, birthDate: Date)
//}
//
////var programer:Person = SwiftProgramer(firstName: "Quan", lastName: "Tran Quoc", bithDate: Date())
//
////if person is SwiftProgramer {
////    print("print Something")
////}
////for person in where person is SwiftProgramer {
////    print("print Something")
////}
//
////as! Runtime error is throw
//
//// if let _ = person as? SwiftProgramer {
////    print("print Something")
////}
//
//protocol TextValidation1 {
//    var regExMatchingString: String {get}
//    var regExFindMatchingString: String {get}
//    var validationMessage: String {get}
//    func validateString(str: String) -> Bool
//    func getMatchingString(str: String) -> String?
//}
//
//class AlphaValidation1: TextValidation1 {
//    static let shareInstance = AlphaValidation1()
//    private init(){}
//    let regExFindMatchingString = "^[a-zA-Z]{0,10}"
//    let validationMessage = "Can only contain Alpha characters"
//    var regExMatchingString: String {
//        get {
//            return regExFindMatchingString + "$"
//        }
//    }
//
//    func validateString(str: String) -> Bool {
//        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
//            return true
//        } else {
//            return false
//        }
//    }
//    func getMatchingString(str: String) -> String? {
//        if let newMatch = str.range(of: regExFindMatchingString, options: .regularExpression) {
//            return str.substring(with: newMatch)
//        } else {
//            return nil
//        }
//    }
//}
//
//protocol TextValidation {
//    var regExMatchingString: String {get}
//    var regExFindMatchingString: String {get}
//}
//
//extension TextValidation {
//    var regExMatchingString: String {
//        get {
//            return regExFindMatchingString + "$"
//        }
//    }
//
//    func validateString(str: String) -> Bool {
//        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
//            return true
//        } else {
//            return false
//        }
//    }
//    func getMatchingString(str: String) -> String? {
//        if let newMatch = str.range(of: regExFindMatchingString, options: .regularExpression) {
//            return str.substring(with: newMatch)
//        } else {
//            return nil
//        }
//    }
//}
//
//class AlphaValidation: TextValidation {
//    static let shareInstance = AlphaValidation()
//    private init(){}
//    let regExFindMatchingString = "^[a-zA-Z]{0,10}"
//    let validationMessage = "Can only contain Alpha characters"
//}
//
//class AlphaNumbericValidation: TextValidation {
//    static let shareInstance = AlphaNumbericValidation()
//    private init(){}
//    let regExFindMatchingString = "^[a-zA-Z0-9]{0,15}"
//    let validationMessage = "Can only contain Alpha characters"
//}
//
//class DisplayNameValidation: TextValidation {
//    static let shareInstance = DisplayNameValidation()
//    private init(){}
//    let regExFindMatchingString = "^[\\s?[a-zA-Z0-9\\-_\\s]]{0,15}"
//    let validationMessage = "Display Name can contain only contain Alphanumberic Characters"
//}
//
//
//extension Int {
//    func factorial() -> Int {
//        var answer = 1
//        for x in (1...self).reversed() {
//            answer *= x
//        }
//        return answer
//    }
//}
//print(10.factorial())

protocol LoggerProfile {
    var loggerProfileId: String {get}
    func writeLog(level: String, message: String)
}

extension LoggerProfile {
    func getCurrentDateString() -> String {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd hh:mm"
        return dateFormater.string(from: date)
    }
}

struct LoggerNull: LoggerProfile {
    let loggerProfileId = "com.quantq.logger.null"
    func writeLog(level: String, message: String) {
        // Nothing to do
    }
}

struct LoggerConsole: LoggerProfile {
    let loggerProfileId = "com.quantq.logger.console"
    func writeLog(level: String, message: String) {
        //
        let now = getCurrentDateString()
        print("\(now): \(level) - \(message)")
    }
}

enum LogLevels: String {
    case Fatal
    case Error
    case Warn
    case Debug
    case Info
    
    static let allValues = [Fatal, Error, Warn, Debug, Info]
}

protocol Logger {
    static var loggers: [LogLevels: [LoggerProfile]] {get set}
    static func writeLog(logLevel: LogLevels, message: String)
}

extension Logger {
    static func logLevelContainsProfile(logLevel: LogLevels, loggerProfile: LoggerProfile) -> Bool {
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles where loggerProfile.loggerProfileId == logProfile.loggerProfileId {
                return true
            }
        }
        return false
    }
    
    static func setLogLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if let _ = loggers[logLevel] {
            if !logLevelContainsProfile(logLevel: logLevel, loggerProfile: loggerProfile) {
                loggers[logLevel]?.append(loggerProfile)
            } else {
                var a = [LoggerProfile]()
                a.append(loggerProfile)
                loggers[logLevel] = a
            }
        }
    }
    static func addLogProfileToAllLevels(defaultLoggerProfile: LoggerProfile) {
        for level in LogLevels.allValues {
            setLogLevel(logLevel: level, loggerProfile: defaultLoggerProfile)
        }
    }
    
    static func removeLogProfileFromLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if var logProfiles = loggers[logLevel] {
            if let index = logProfiles.index(where: {$0.loggerProfileId == loggerProfile.loggerProfileId}) {
                logProfiles.remove(at: index)
            }
            loggers[logLevel] = logProfiles
        }
    }
    
    static func removeLogProfileFromAllLevels(loggerProfile: LoggerProfile) {
        for level in LogLevels.allValues {
            removeLogProfileFromLevel(logLevel: level, loggerProfile: loggerProfile)
        }
    }
    
    static func hasLoggerForLevel(logLevel: LogLevels) -> Bool {
        guard let _ = loggers[logLevel] else {
            return false
        }
        return true
    }
}

struct MyLogger: Logger {
    static var loggers = [LogLevels : [LoggerProfile]]()
    static func writeLog(logLevel: LogLevels, message: String) {
        guard hasLoggerForLevel(logLevel: logLevel) else {
            print("No logger")
            return
        }
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles {
                logProfile.writeLog(level: logLevel.rawValue, message: message)
            }
        }
    }
}
