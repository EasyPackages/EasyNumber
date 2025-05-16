///
/// A list of standardized ISO 4217 currency codes.
///
/// Use this enum to avoid hardcoding currency strings, ensure consistency,
/// and enable auto-completion when formatting currency values.
///
/// This list includes the most commonly used global currencies.
///
/// - Example:
/// ```swift
/// let formatter = NumberFormatter.currency(code: CurrencyCode.usd.rawValue)
/// let result = 149.99.formatted(formatter)
/// ```
///
public enum CurrencyCode: String, CaseIterable {

    /// United States Dollar
    case usd = "USD"

    /// Euro (used by Eurozone countries)
    case eur = "EUR"

    /// Brazilian Real
    case brl = "BRL"

    /// British Pound Sterling
    case gbp = "GBP"

    /// Japanese Yen
    case jpy = "JPY"

    /// Chinese Yuan Renminbi
    case cny = "CNY"

    /// Indian Rupee
    case inr = "INR"

    /// Australian Dollar
    case aud = "AUD"

    /// Canadian Dollar
    case cad = "CAD"

    /// Swiss Franc
    case chf = "CHF"

    /// Mexican Peso
    case mxn = "MXN"

    /// South African Rand
    case zar = "ZAR"

    /// Russian Ruble
    case rub = "RUB"

    /// South Korean Won
    case krw = "KRW"

    /// Swedish Krona
    case sek = "SEK"

    /// Norwegian Krone
    case nok = "NOK"

    /// Danish Krone
    case dkk = "DKK"

    /// Argentine Peso
    case ars = "ARS"

    /// Chilean Peso
    case clp = "CLP"

    /// Colombian Peso
    case cop = "COP"

    /// Peruvian Sol
    case pen = "PEN"

    /// Thai Baht
    case thb = "THB"

    /// Indonesian Rupiah
    case idr = "IDR"

    /// Vietnamese Dong
    case vnd = "VND"

    /// Philippine Peso
    case php = "PHP"

    /// Hong Kong Dollar
    case hkd = "HKD"

    /// Singapore Dollar
    case sgd = "SGD"

    /// Malaysian Ringgit
    case myr = "MYR"

    /// Polish Zloty
    case pln = "PLN"

    /// Czech Koruna
    case czk = "CZK"

    /// Hungarian Forint
    case huf = "HUF"

    /// Romanian Leu
    case ron = "RON"

    /// Turkish Lira
    case `try` = "TRY"

    /// Egyptian Pound
    case egp = "EGP"

    /// Nigerian Naira
    case ngn = "NGN"

    /// Kenyan Shilling
    case kes = "KES"

    /// Ukrainian Hryvnia
    case uah = "UAH"

    /// Israeli New Shekel
    case ils = "ILS"

    /// Saudi Riyal
    case sar = "SAR"

    /// UAE Dirham
    case aed = "AED"

    /// Bangladeshi Taka
    case bdt = "BDT"

    /// Sri Lankan Rupee
    case lkr = "LKR"

    /// Pakistani Rupee
    case pkr = "PKR"

    /// Moroccan Dirham
    case mad = "MAD"

    /// Tunisian Dinar
    case tnd = "TND"

    /// Qatari Riyal
    case qar = "QAR"

    /// Omani Rial
    case omr = "OMR"

    /// Bulgarian Lev
    case bgn = "BGN"

    /// Serbian Dinar
    case rsd = "RSD"

    /// Croatian Kuna (used before euro adoption)
    case hrk = "HRK"

    /// Icelandic Krona
    case isk = "ISK"
}
