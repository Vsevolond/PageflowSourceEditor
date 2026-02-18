//
//  CaptureNames.swift
//  CodeEditSourceEditor
//
//  Created by Lukas Pistrol on 16.08.22.
//

/// A collection of possible syntax capture types. Represented by an integer for memory efficiency, and with the
/// ability to convert to and from strings for ease of use with tools.
///
/// This is `Int8` raw representable for memory considerations. In large documents there can be *lots* of these created
/// and passed around, so representing them with a single integer is preferable to a string to save memory.
///
public enum CaptureName: Int8, CaseIterable, Sendable {
    case block
    case modifier
    case type
    case typeValue
    case number
    case constant
    case boolean
    case string
    case mathString
    case fileString
    case textSeparator
    case textDelimiter
    case mathDelimiter

    /// Returns a specific capture name case from a given string.
    /// - Note: See ``CaptureName`` docs for why this enum isn't a raw representable.
    /// - Parameter string: A string to get the capture name from
    /// - Returns: A `CaptureNames` case
    public static func fromString(_ string: String?) -> CaptureName? {
        guard let string else { return nil }
        switch string {
        case "block":
            return .block
        case "modifier":
            return .modifier
        case "type":
            return .type
        case "type.value":
            return .typeValue
        case "number":
            return .number
        case "constant":
            return .constant
        case "boolean":
            return .boolean
        case "string":
            return .string
        case "string.math":
            return .mathString
        case "string.file":
            return .fileString
        case "text.separator":
            return .textSeparator
        case "text.delimiter":
            return .textDelimiter
        case "math.delimiter":
            return .mathDelimiter
        default:
            return nil
        }
    }

    /// See ``CaptureName`` docs for why this enum isn't a raw representable.
    var stringValue: String {
        switch self {
        case .block:
            return "block"
        case .modifier:
            return "modifier"
        case .type:
            return "type"
        case .typeValue:
            return "typeValue"
        case .number:
            return "number"
        case .constant:
            return "constant"
        case .boolean:
            return "boolean"
        case .string:
            return "string"
        case .mathString:
            return "mathString"
        case .fileString:
            return "fileString"
        case .textSeparator:
            return "textSeparator"
        case .textDelimiter:
            return "textDelimiter"
        case .mathDelimiter:
            return "mathDelimiter"
        }
    }
}

extension CaptureName: CustomDebugStringConvertible {
    public var debugDescription: String { stringValue }
}
