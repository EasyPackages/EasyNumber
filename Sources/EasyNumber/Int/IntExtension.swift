import Foundation

///
/// Convenience formatting utilities for `Int`, using `NumberFormatter`.
///
/// Enables transforming integers into localized strings using custom or preset formatters,
/// and provides conversion helpers to other numeric types.
///
/// - Example:
/// ```swift
/// let total = 1000
/// total.formatted(.currency) // "$1,000.00" or localized
/// ```
///
public extension Int {
    
    ///
    /// Formats the integer using a specified `NumberFormatter`.
    ///
    /// - Parameters:
    ///   - formatter: A configured `NumberFormatter` instance.
    ///   - locale: The `Locale` to apply. Defaults to `.current`.
    /// - Returns: A localized string or `nil` if formatting fails.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1500
    /// let formatted = value.formatted(NumberFormatter.decimal)
    /// ```
    ///
    func formatted(_ formatter: NumberFormatter, locale: Locale = .current) -> String? {
        formatter.locale = locale
        return formatter.string(from: number)
    }
    
    ///
    /// Converts the integer to a `Double`.
    ///
    /// Useful when you need floating-point precision based on an integer input.
    ///
    /// - Example:
    /// ```swift
    /// let value = 42
    /// let asDouble = value.double // 42.0
    /// ```
    ///
    var double: Double? {
        Double(self)
    }

    ///
    /// Converts the integer to a `Float`.
    ///
    /// Useful when a lower-precision floating-point value is needed.
    ///
    /// - Example:
    /// ```swift
    /// let value = 42
    /// let asFloat = value.float // 42.0
    /// ```
    ///
    var float: Float? {
        Float(self)
    }

    ///
    /// Returns the integer value as an `NSNumber`.
    ///
    /// Useful for interacting with `NumberFormatter`, Objective-C APIs, or data persistence.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1000
    /// let number = value.number
    /// ```
    /// 
    var number: NSNumber {
        self as NSNumber
    }
}
