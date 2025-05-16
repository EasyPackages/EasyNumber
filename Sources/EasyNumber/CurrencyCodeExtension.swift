import Foundation

public extension CurrencyCode {
    
    ///
    /// Returns the `CurrencyCode` inferred from the user's current locale, if available.
    ///
    /// This is useful when you want to automatically adapt currency-related features
    /// to the user's regional settings without manually specifying the currency.
    ///
    /// - Example:
    /// ```swift
    /// let currentCode = CurrencyCode.current
    /// print(currentCode) // Optional(.brl) for pt_BR
    /// ```
    ///
    static var current: CurrencyCode {
        CurrencyCode(locale: .current)
    }
    
    ///
    /// Initializes a `CurrencyCode` from a given `Locale`, falling back to a default currency code if none is found.
    ///
    /// This initializer attempts to infer the ISO 4217 currency code based on the provided `Locale`.
    /// If the locale does not have an associated currency, or the resolved currency is not supported by `CurrencyCode`,
    /// the specified `fallback` value will be used instead.
    ///
    /// - Parameters:
    ///   - locale: The `Locale` from which to extract the currency code.
    ///   - fallback: The currency code to use if the locale doesn't resolve to a supported one. Defaults to `.usd`.
    ///
    /// - Example:
    /// ```swift
    /// let brl = CurrencyCode(locale: Locale(identifier: "pt_BR")) // .brl
    /// let unknown = CurrencyCode(locale: Locale(identifier: "xx_YY")) // .usd (fallback)
    /// let euro = CurrencyCode(locale: Locale(identifier: "fr_FR"), fallback: .eur) // .eur
    /// ```
    ///
    init(locale: Locale, fallback: CurrencyCode = .usd) {
        if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *) {
            if let currencyCode = locale.currency?.identifier {
                self = CurrencyCode(rawValue: currencyCode) ?? fallback
            } else {
                self = fallback
            }
        } else if let currencyCode = locale.currencyCode {
            self = CurrencyCode(rawValue: currencyCode) ?? fallback
        } else {
            self = fallback
        }
    }
}
