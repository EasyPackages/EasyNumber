import Foundation

public extension NumberFormatter {
    ///
    /// A custom NumberFormatter subclass that returns currency values written out in full words,
    /// including support for negative values.
    ///
    /// Example:
    /// ```swift
    /// let formatter = CurrencySpellOutNumberFormatter()
    /// formatter.locale = Locale(identifier: "pt_BR")
    /// print(formatter.string(from: -1234.56))
    /// // "menos mil duzentos e trinta e quatro reais e cinquenta e seis centavos"
    /// ```
    ///
    final class CurrencySpellOutNumberFormatter: NumberFormatter, @unchecked Sendable {
        public override func string(from number: NSNumber) -> String? {
            let value = number.doubleValue
            let isNegative = value < 0
            let absValue = abs(value)
            let majorUnit = Int(absValue)
            let minorUnit = Int((absValue * 100).truncatingRemainder(dividingBy: 100))

            let spellOutFormatter = NumberFormatter()
            spellOutFormatter.numberStyle = .spellOut
            spellOutFormatter.locale = self.locale

            let currency = Self.currencyNames[locale.identifier]
                ?? Self.currencyNames[String(locale.languageCode ?? "en") + "_" + String((locale.regionCode ?? "US"))]
                ?? Self.currencyNames["en_US"]!

            let majorText = majorUnit > 0 ? spellOutFormatter.string(from: NSNumber(value: majorUnit)) : nil
            let minorText = minorUnit > 0 ? spellOutFormatter.string(from: NSNumber(value: minorUnit)) : nil

            let majorLabel = majorUnit == 1 ? currency.major.0 : currency.major.1
            let minorLabel = minorUnit == 1 ? currency.minor.0 : currency.minor.1

            var result: String?
            switch (majorText, minorText) {
            case let (m?, c?):
                result = "\(m) \(majorLabel) \(Self.join(locale: locale)) \(c) \(minorLabel)"
            case let (m?, nil):
                result = "\(m) \(majorLabel)"
            case let (nil, c?):
                result = "\(c) \(minorLabel)"
            default:
                result = nil
            }

            if let res = result, isNegative {
                let minusWord = Self.minusWord(locale: locale)
                return "\(minusWord) \(res)"
            }
            return result
        }

        /// Returns the conjunction word for currency values in the specified locale.
        private static func join(locale: Locale) -> String {
            switch locale.identifier {
            case "pt_BR", "pt_PT", "it_IT": return "e"
            case "fr_FR": return "et"
            case "es_ES": return "y"
            case "de_DE": return "und"
            case "ru_RU": return "и"
            case "ar_SA": return "و"
            case "tr_TR": return "ve"
            case "ja_JP": return "と"
            case "zh_CN": return "和"
            case "ko_KR": return "그리고"
            case "hi_IN": return "और"
            default: return "and"
            }
        }

        /// Returns the word for minus/negative for the specified locale.
        private static func minusWord(locale: Locale) -> String {
            switch locale.identifier {
            case "pt_BR", "pt_PT": return "menos"
            case "en_US", "en_GB": return "minus"
            case "es_ES": return "menos"
            case "fr_FR": return "moins"
            case "de_DE": return "minus"
            case "it_IT": return "meno"
            case "ru_RU": return "минус"
            case "ar_SA": return "ناقص"
            case "tr_TR": return "eksi"
            case "ja_JP": return "マイナス"
            case "zh_CN": return "负"
            case "ko_KR": return "마이너스"
            case "hi_IN": return "माइनस"
            default: return "minus"
            }
        }

        /// Currency major/minor names for supported locales.
        private static let currencyNames: [String: (major: (String, String), minor: (String, String))] = [
            "pt_BR": (("real", "reais"), ("centavo", "centavos")),
            "en_US": (("dollar", "dollars"), ("cent", "cents")),
            "es_ES": (("euro", "euros"), ("céntimo", "céntimos")),
            "fr_FR": (("euro", "euros"), ("centime", "centimes")),
            "de_DE": (("euro", "euros"), ("cent", "cents")),
            "it_IT": (("euro", "euro"), ("centesimo", "centesimi")),
            "ja_JP": (("円", "円"), ("銭", "銭")),
            "zh_CN": (("元", "元"), ("角", "角")),
            "ru_RU": (("рубль", "рублей"), ("копейка", "копеек")),
            "ar_SA": (("ريال", "ريالات"), ("هللة", "هللات")),
            "hi_IN": (("रुपया", "रुपये"), ("पैसा", "पैसे")),
            "ko_KR": (("원", "원"), ("전", "전")),
            "tr_TR": (("lira", "lira"), ("kuruş", "kuruş")),
            "pl_PL": (("złoty", "złote"), ("grosz", "grosze")),
            "nl_NL": (("euro", "euro"), ("cent", "cent")),
            "sv_SE": (("krona", "kronor"), ("öre", "öre")),
            "da_DK": (("krone", "kroner"), ("øre", "øre")),
            "nb_NO": (("krone", "kroner"), ("øre", "øre")),
            "pt_PT": (("euro", "euros"), ("cêntimo", "cêntimos")),
            "en_GB": (("pound", "pounds"), ("penny", "pence"))
        ]
    }
}
