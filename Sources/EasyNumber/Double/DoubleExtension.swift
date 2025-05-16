import Foundation

///
/// Formatting helpers for `Double` values using `NumberFormatter`.
///
/// Provides localized representations of decimal or currency values and
/// basic casting utilities to convert `Double` into `Int`, `Float`, or `NSNumber`.
///
/// - Example:
/// ```swift
/// let price = 1999.99
/// price.formatted(.currency) // "$1,999.99"
/// ```
/// 
public extension Double {
    
    ///
    /// Formats the double using a specified `NumberFormatter`.
    ///
    /// - Parameters:
    ///   - formatter: A configured `NumberFormatter` instance.
    ///   - locale: The `Locale` to apply. Defaults to `.current`.
    /// - Returns: A localized string or `nil` if formatting fails.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1234.56
    /// let formatted = value.formatted(NumberFormatter.currency)
    /// ```
    ///
    func formatted(_ formatter: NumberFormatter, locale: Locale = .current) -> String? {
        formatter.locale = locale
        return formatter.string(from: number)
    }

    ///
    /// Returns the double value converted to an `Int`, discarding the decimal portion.
    ///
    /// - Example:
    /// ```swift
    /// let value: Double = 123.45
    /// let intValue = value.int // 123
    /// ```
    ///
    var int: Int? {
        if isNaN || isInfinite {
            return nil
        }
        
        return Int(self)
    }

    ///
    /// Returns the double value converted to a `Float`.
    ///
    /// - Example:
    /// ```swift
    /// let value: Double = 123.45
    /// let floatValue = value.float // 123.45 as Float
    /// ```
    ///
    var float: Float? {
        Float(self)
    }

    ///
    /// Returns the double value as an `NSNumber`.
    ///
    /// Useful when interacting with APIs or formatters that require `NSNumber`.
    ///
    /// - Example:
    /// ```swift
    /// let value: Double = 123.45
    /// let number = value.number
    /// ```
    ///
    var number: NSNumber {
        self as NSNumber
    }
}
