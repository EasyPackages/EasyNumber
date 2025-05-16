import Foundation

///
/// Preconfigured `NumberFormatter` instances optimized for currency and decimal formatting.
///
/// Use these formatters with `.formatted(_:)` on `Int`, `Double`, or `Float`.
///
/// - Example:
/// ```swift
/// let value = 500.0
/// value.formatted(.currency) // "$500.00" or localized
/// ```
///
public extension NumberFormatter {
    
    ///
    /// Creates a fully configurable currency formatter using a given currency code, symbol, and precision.
    ///
    /// This method returns a `NumberFormatter` configured to format currency values
    /// based on the provided currency code. You can also override the number of decimal places (precision)
    /// and the currency symbol, if needed.
    ///
    /// This is useful when displaying monetary values in different currencies, customizing
    /// the symbol for disambiguation (e.g. US$ vs CA$), or adjusting the number of fraction digits.
    ///
    /// - Parameters:
    ///   - code: The currency code to use (e.g. `.usd`, `.brl`, `.eur`). Defaults to `.current`, which resolves from the user's current locale.
    ///   - precision: The number of decimal places to display. Defaults to `2`.
    ///   - symbol: An optional override for the currency symbol (e.g. use `.usd` to display `"US$"` instead of just `"$"`).
    ///
    /// - Returns: A fully configured `NumberFormatter` instance ready to format currency values.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1234.5
    ///
    /// // Basic usage with default settings (user's locale currency and 2 digits)
    /// let formatter = NumberFormatter.currency()
    /// print(value.formatted(formatter)) // "R$ 1.234,50" (for pt_BR)
    ///
    /// // Use a specific currency
    /// let usdFormatter = NumberFormatter.currency(code: .usd)
    /// print(value.formatted(usdFormatter)) // "$1,234.50"
    ///
    /// // Use custom symbol (e.g., US$)
    /// let customSymbol = NumberFormatter.currency(code: .usd, symbol: .usd)
    /// print(value.formatted(customSymbol)) // "US$1,234.50"
    ///
    /// // Use no decimal places
    /// let rounded = NumberFormatter.currency(code: .jpy, precision: 0)
    /// print(value.formatted(rounded)) // "¥1,235"
    /// ```
    ///
    static func currency(code: CurrencyCode? = nil, precision: Int = 2, symbol: CurrencyCode? = nil) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = code?.rawValue
        formatter.currencySymbol = symbol?.rawValue
        formatter.minimumFractionDigits = precision
        formatter.maximumFractionDigits = precision
        return formatter
    }
    
    /// A formatter for percentages using the current locale.
    ///
    /// This formatter multiplies the number by 100 and adds the percent symbol.
    ///
    /// - Example:
    /// ```swift
    /// let value = 0.25
    /// print(value.formatted(.percent)) // "25%"
    /// ```
    static var percent: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///
    /// A formatter for general decimal numbers with grouping separators.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1234567.89
    /// print(value.formatted(.decimal)) // "1,234,567.89"
    /// ```
    ///
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    ///
    /// A formatter for scientific notation.
    ///
    /// Converts numbers to exponential notation like "1E6".
    ///
    /// - Example:
    /// ```swift
    /// let value = 1000000.0
    /// print(value.formatted(.scientific)) // "1E6"
    /// ```
    ///
    static var scientific: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.exponentSymbol = "E"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    ///
    /// A formatter for currency values using accounting style.
    ///
    /// This style wraps negative values in parentheses instead of using a minus sign.
    ///
    /// - Example:
    /// ```swift
    /// let value = -1000.0
    /// print(value.formatted(.currencyAccounting())) // "($1,000.00)"
    /// ```
    ///
    static func currencyAccounting(code: CurrencyCode = .current, precision: Int = 2, symbol: CurrencyCode? = nil) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyCode = code.rawValue
        formatter.currencySymbol = symbol?.rawValue
        formatter.minimumFractionDigits = precision
        formatter.maximumFractionDigits = precision
        return formatter
    }
    
    ///
    /// A formatter that uses ISO currency codes (e.g., "USD", "EUR") instead of symbols like "$" or "€".
    ///
    /// Useful for disambiguating currencies in international contexts.
    ///
    /// - Example:
    /// ```swift
    /// let value = 1000.0
    /// print(value.formatted(.currencyISOCode())) // "USD 1,000.00"
    /// ```
    ///
    static func currencyISOCode(code: CurrencyCode = .current, precision: Int = 2) ->  NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyISOCode
        formatter.minimumFractionDigits = precision
        formatter.maximumFractionDigits = precision
        return formatter
    }
    
    ///
    /// A formatter that writes numbers out in full words (e.g. `"one thousand"`).
    ///
    /// This is useful for accessibility, invoices, checks, or educational purposes.
    ///
    /// - Note:
    ///   The formatting is locale-sensitive. For example:
    ///   - `Locale(identifier: "en_US")` → `"one thousand"`
    ///   - `Locale(identifier: "pt_BR")` → `"mil"`
    ///
    /// - Example:
    /// ```swift
    /// let result = 1234.formatted(using: .spellOut, locale: Locale(identifier: "pt_BR"))
    /// print(result) // "mil duzentos e trinta e quatro"
    /// ```
    ///
    /// - Returns: A `NumberFormatter` instance configured for spelling numbers out in full words.
    ///
    static var spellOut: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }
    
    ///
    /// A specialized `NumberFormatter` that spells out currency values in full words,
    /// using the user's current locale settings.
    ///
    /// This formatter is ideal for contexts like printed invoices, contracts, accessibility support,
    /// or educational applications where monetary values need to be written out completely.
    ///
    /// Internally, it uses a custom subclass `CurrencySpellOutNumberFormatter` to determine
    /// the correct major (e.g., dollars, euros, reais) and minor (e.g., cents, centavos) unit names,
    /// as well as the appropriate conjunction (e.g., “and”, “e”, “et”) based on locale.
    ///
    /// - Example:
    /// ```swift
    /// let formatter = NumberFormatter.currencySpellOut
    /// formatter.locale = Locale(identifier: "pt_BR")
    /// print(formatter.string(from: 1234.56)) // "mil duzentos e trinta e quatro reais e cinquenta e seis centavos"
    /// ```
    ///
    /// - Returns: A `NumberFormatter` that spells out currency amounts.
    /// 
    static var currencySpellOut: NumberFormatter {
        CurrencySpellOutNumberFormatter()
    }
}
