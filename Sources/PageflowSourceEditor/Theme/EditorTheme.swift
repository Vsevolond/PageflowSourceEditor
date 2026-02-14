//
//  EditorTheme.swift
//  CodeEditSourceEditor
//
//  Created by Lukas Pistrol on 29.05.22.
//

import SwiftUI

/// A collection of attributes used for syntax highlighting and other colors for the editor.
///
/// Attributes of a theme that do not apply to text (background, line highlight) are a single `NSColor` for simplicity.
/// All other attributes use the ``EditorTheme/Attribute`` type to store
public struct EditorTheme: Equatable {
    /// Represents attributes that can be applied to style text.
    public struct Attribute: Equatable, Hashable, Sendable {
        public let color: NSColor
        public let bold: Bool
        public let italic: Bool

        public init(color: NSColor, bold: Bool = false, italic: Bool = false) {
            self.color = color
            self.bold = bold
            self.italic = italic
        }
    }

    public var text: Attribute
    public var insertionPoint: NSColor
    public var invisibles: Attribute
    public var background: NSColor
    public var lineHighlight: NSColor
    public var selection: NSColor
    public var keywords: Attribute
    public var commands: Attribute
    public var types: Attribute
    public var builtinTypes: Attribute
    public var attributes: Attribute
    public var variables: Attribute
    public var functions: Attribute
    public var values: Attribute
    public var numbers: Attribute
    public var strings: Attribute
    public var specialStrings: Attribute
    public var characters: Attribute
    public var constants: Attribute
    public var builtinConstants: Attribute
    public var specialPunctuation: Attribute
    public var comments: Attribute

    public init(
        text: Attribute,
        insertionPoint: NSColor,
        invisibles: Attribute,
        background: NSColor,
        lineHighlight: NSColor,
        selection: NSColor,
        keywords: Attribute,
        commands: Attribute,
        types: Attribute,
        builtinTypes: Attribute,
        attributes: Attribute,
        variables: Attribute,
        functions: Attribute,
        values: Attribute,
        numbers: Attribute,
        strings: Attribute,
        specialStrings: Attribute,
        characters: Attribute,
        constants: Attribute,
        builtinConstants: Attribute,
        specialPunctuation: Attribute,
        comments: Attribute
    ) {
        self.text = text
        self.insertionPoint = insertionPoint
        self.invisibles = invisibles
        self.background = background
        self.lineHighlight = lineHighlight
        self.selection = selection
        self.keywords = keywords
        self.commands = commands
        self.types = types
        self.builtinTypes = builtinTypes
        self.attributes = attributes
        self.variables = variables
        self.functions = functions
        self.values = values
        self.numbers = numbers
        self.strings = strings
        self.specialStrings = specialStrings
        self.characters = characters
        self.constants = constants
        self.builtinConstants = builtinConstants
        self.specialPunctuation = specialPunctuation
        self.comments = comments
    }

    /// Maps a capture type to the attributes for that capture determined by the theme.
    /// - Parameter capture: The capture to map to.
    /// - Returns: Theme attributes for the capture.
    private func mapCapture(_ capture: CaptureName?) -> Attribute {
        switch capture {
        case .include, .constructor, .keyword, .boolean, .variableBuiltin,
                .keywordReturn, .keywordFunction, .repeat, .conditional, .tag:
            return keywords
        case .comment: return comments
        case .variable, .property: return variables
        case .function, .functionBuiltin, .method: return functions
        case .number, .float: return numbers
        case .string: return strings
        case .stringSpecial: return specialStrings
        case .type: return types
        case .typeBuiltin: return builtinTypes
        case .parameter: return variables
        case .typeAlternate: return attributes
        case .constant: return constants
        case .constantBuiltin: return builtinConstants
        case .punctuationSpecial: return specialPunctuation
        default: return text
        }
    }

    /// Get the color from ``theme`` for the specified capture name.
    /// - Parameter capture: The capture name
    /// - Returns: A `NSColor`
    func colorFor(_ capture: CaptureName?) -> NSColor {
        return mapCapture(capture).color
    }

    /// Returns the correct font with attributes (bold and italics) for a given capture name.
    /// - Parameters:
    ///   - capture: The capture name.
    ///   - font: The font to add attributes to.
    /// - Returns: A new font that has the correct attributes for the capture.
    func fontFor(for capture: CaptureName?, from font: NSFont) -> NSFont {
        let attributes = mapCapture(capture)
        guard attributes.bold || attributes.italic else {
            return font
        }

        var font = font

        if attributes.bold {
            font = NSFontManager.shared.convert(font, toHaveTrait: .boldFontMask)
        }

        if attributes.italic {
            font = NSFontManager.shared.convert(font, toHaveTrait: .italicFontMask)
        }

        return font
    }
}
