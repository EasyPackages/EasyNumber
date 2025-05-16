import Foundation
import EasyCore

///
/// Numeric conversion utilities for `String` values, supporting localized,
/// currency, percent, abbreviated, and mathematical formats.
///
/// These helpers make it easy to parse user input, CSVs, reports, or text values
/// that represent numbers in various forms, respecting locale-specific formatting.
///
/// Supported formats:
/// - Standard numbers with any decimal/grouping separators
/// - Currency (symbols, codes, and region-specific postfixes)
/// - Percentages (`%`)
/// - Abbreviations for large values (`K`, `M`, `B`, `T`, `Q`)
/// - Mathematical operations: factorial (`!`), square root (`√`), power (`^`, `**`)
///
/// - Example:
/// ```swift
/// "R$ 1.234,56".double(locale: .ptBR) // 1234.56
/// "US$ -1,000.50".double(locale: .enUS) // -1000.50
/// "10%".double() // 0.10
/// "2K".int() // 2000
/// "5!".double() // 120.0
/// "√25".double() // 5.0
/// "2^8".double() // 256.0
/// "1,000円".int(locale: .jaJP) // 1000
/// ```
///
public extension String {
    
    ///
    /// Attempts to parse the string as a `Double` using the provided `Locale`.
    ///
    /// This method is highly resilient, supporting numbers in most real-world formats,
    /// including currency, grouping separators, abbreviations, mathematical operators,
    /// and localized decimal/grouping conventions.
    ///
    /// - Parameter locale: The locale to use for parsing. Defaults to `.current`.
    /// - Returns: The parsed `Double` value, or `nil` if conversion fails.
    ///
    /// - Example:
    /// ```swift
    /// "R$ 1.234,56".double(locale: .ptBR) // 1234.56
    /// "2K".double() // 2000.0
    /// "10%".double() // 0.10
    /// ```
    ///
    func double(locale: Locale = .current) -> Double? {
        convert(locale: locale)?.doubleValue
    }
    
    ///
    /// Attempts to parse the string as a `Float` using the provided `Locale`.
    ///
    /// See `double(locale:)` for the full list of supported formats.
    ///
    /// - Parameter locale: The locale to use for parsing. Defaults to `.current`.
    /// - Returns: The parsed `Float` value, or `nil` if conversion fails.
    ///
    /// - Example:
    /// ```swift
    /// "8,25".float(locale: .ptBR) // 8.25
    /// "2M".float() // 2_000_000.0
    /// ```
    ///
    func float(locale: Locale = .current) -> Float? {
        convert(locale: locale)?.floatValue
    }
    
    ///
    /// Attempts to parse the string as an `Int` using the provided `Locale`.
    ///
    /// Parses as many valid digits as possible, handling common real-world
    /// input scenarios such as grouping, currency, mathematical operators,
    /// abbreviations, and localized separators.
    ///
    /// - Parameter locale: The locale to use for parsing. Defaults to `.current`.
    /// - Returns: The parsed `Int` value, or `nil` if conversion fails.
    ///
    /// - Example:
    /// ```swift
    /// "R$ 1.000".int(locale: .ptBR) // 1000
    /// "(1000円)".int(locale: .jaJP) // 1000
    /// "10K".int() // 10000
    /// ```
    ///
    func int(locale: Locale = .current) -> Int? {
        convert(locale: locale)?.intValue
    }
    
    private func convert(locale: Locale = .current) -> NSNumber? {
        var raw = self
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        
        if let symbol = locale.currencySymbol {
            raw = raw.removeOcurrencing(symbol)
        }
        
        if let currencyCode = locale.currencyCode {
            raw = raw.removeOcurrencing(currencyCode)
            let partialCurrencyCode = String(Array(currencyCode)[0..<currencyCode.count - 1])
            raw = raw.removeOcurrencing(partialCurrencyCode)
        }
        
        let multipliers = ["K": 3, "M": 6, "B": 9, "T": 12, "Q": 15]
        let lastCharacter = String(raw.last ?? "?")
        if let multiplier = multipliers[lastCharacter] {
            let zero = String(Int.zero)
            raw = raw.removeOcurrencing(lastCharacter)
            if raw.contains(formatter.groupingSeparator) {
                raw = raw + String(repeating: zero, count: multiplier - 1)
            } else {
                raw = raw + String(repeating: zero, count: multiplier)
            }
        }
        
        let complements: [Locale: String] = [
            .jaJP: "円",
            .zhCN: "元",
            .zhTW: "元",
        ]
        if let complement = complements[locale] {
            raw = raw.removeOcurrencing(complement)
        }
        
        raw = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        raw = raw.removeOcurrencing(formatter.groupingSeparator)
        
        raw = raw.replacingOccurrences(of: formatter.decimalSeparator, with: ".")
        
        var value: Double?
        
        if let op = Optional("%"), raw.last == Character(op) {
            raw = raw.removeOcurrencing(op)
            value = Double(raw).map { $0 / 100 }
        } else if let op = Optional("!"), raw.last == Character(op) {
            raw = raw.removeOcurrencing(op)
            value = Int(raw).map { v in
                Double((1...max(1, v)).reduce(1, *))
            }
        } else if let op = Optional("√"), raw.hasPrefix(op) {
            raw = raw.removeOcurrencing(op)
            value = Double(raw).map { sqrt($0) }
        } else if let powMatch = raw.range(of: #"^(-?\d+(?:\.\d+)?)[\^*]{1,2}(-?\d+(?:\.\d+)?)$"#, options: .regularExpression) {
            let expr = String(raw[powMatch])
            let parts = expr.components(separatedBy: CharacterSet(charactersIn: "^*"))
            if parts.count == 2, let base = Double(parts[0]), let exp = Double(parts[1]) {
                value = pow(base, exp)
            }
        } else {
            value = Double(raw)
        }
        
        return value?.isNaN == true ? nil : value as? NSNumber
    }
}
