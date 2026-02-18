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

    public var blocks: Attribute
    public var modifiers: Attribute
    public var types: Attribute
    public var typeValues: Attribute
    public var numbers: Attribute
    public var constants: Attribute
    public var booleans: Attribute
    public var strings: Attribute
    public var mathStrings: Attribute
    public var fileStrings: Attribute
    public var textSeparator: Attribute
    public var textDelimiter: Attribute
    public var mathDelimiter: Attribute

    public init(
        text: Attribute,
        insertionPoint: NSColor,
        invisibles: Attribute,
        background: NSColor,
        lineHighlight: NSColor,
        selection: NSColor,
        blocks: Attribute,
        modifiers: Attribute,
        types: Attribute,
        typeValues: Attribute,
        numbers: Attribute,
        constants: Attribute,
        booleans: Attribute,
        strings: Attribute,
        mathStrings: Attribute,
        fileStrings: Attribute,
        textSeparator: Attribute,
        textDelimiter: Attribute,
        mathDelimiter: Attribute
    ) {
        self.text = text
        self.insertionPoint = insertionPoint
        self.invisibles = invisibles
        self.background = background
        self.lineHighlight = lineHighlight
        self.selection = selection
        self.blocks = blocks
        self.modifiers = modifiers
        self.types = types
        self.typeValues = typeValues
        self.numbers = numbers
        self.constants = constants
        self.booleans = booleans
        self.strings = strings
        self.mathStrings = mathStrings
        self.fileStrings = fileStrings
        self.textSeparator = textSeparator
        self.textDelimiter = textDelimiter
        self.mathDelimiter = mathDelimiter
    }

    /// Maps a capture type to the attributes for that capture determined by the theme.
    /// - Parameter capture: The capture to map to.
    /// - Returns: Theme attributes for the capture.
    private func mapCapture(_ capture: CaptureName?) -> Attribute {
        switch capture {
        case .block: return blocks
        case .modifier: return modifiers
        case .type: return types
        case .typeValue: return typeValues
        case .number: return numbers
        case .constant: return constants
        case .boolean: return booleans
        case .string: return strings
        case .mathString: return mathStrings
        case .fileString: return fileStrings
        case .textSeparator: return textSeparator
        case .textDelimiter: return textDelimiter
        case .mathDelimiter: return mathDelimiter
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
