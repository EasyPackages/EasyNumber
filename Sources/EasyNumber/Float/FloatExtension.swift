import Foundation

///
/// Formatting helpers for `Float` values using `NumberFormatter`.
///
/// Suitable for lower-precision numbers requiring localization or readable output,
/// and useful for formatting values like scores, percentages, or short decimals.
///
/// - Example:
/// ```swift
/// let score: Float = 8.75
/// score.formatted(.decimal) // "8.75"
/// ```
///
public extension Float {
    
    ///
    /// Formats the float using a specified `NumberFormatter`.
    ///
    /// - Parameters:
    ///   - formatter: A configured `NumberFormatter` instance.
    ///   - locale: The `Locale` to apply. Defaults to `.current`.
    /// - Returns: A localized string or `nil` if formatting fails.
    ///
    /// - Example:
    /// ```swift
    /// let temperature: Float = 36.6
    /// let formatted = temperature.formatted(NumberFormatter.decimal)
    /// ```
    ///
    func formatted(using formatter: NumberFormatter, locale: Locale = .current) -> String? {
        formatter.locale = locale
        return formatter.string(from: number)
    }
    
    ///
    /// Returns the float value converted to a `Double`.
    ///
    /// Useful when interacting with APIs or libraries that expect `Double` types.
    ///
    /// - Example:
    /// ```swift
    /// let value: Float = 1.5
    /// let result = value.double // 1.5 as Double
    /// ```
    ///
    var double: Double? {
        Double(self)
    }

    ///
    /// Returns the float value converted to an `Int`, truncating the decimal.
    ///
    /// - Example:
    /// ```swift
    /// let value: Float = 9.99
    /// let result = value.int // 9
    /// ```
    ///
    var int: Int? {
        Int(self)
    }

    ///
    /// Returns the float value wrapped in an `NSNumber` object.
    ///
    /// Useful for passing values to `NumberFormatter` or Objective-C APIs.
    ///
    /// - Example:
    /// ```swift
    /// let value: Float = 3.14
    /// let number = value.number
    /// ```
    ///
    var number: NSNumber {
        self as NSNumber
    }
}
