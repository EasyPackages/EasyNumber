import Testing
import Foundation

@testable import EasyNumber

@Suite("NumberFormatter Extensions")
struct NumberFormatterExtensionsTests {
    
    @Test("currency() produces localized values")
    func testCurrency() {
        let value = 1234.56
        
        let usd = NumberFormatter.currency()
        #expect(value.formatted(usd, locale: .enUS) == "$1,234.56")
        
        let brl = NumberFormatter.currency(code: .brl)
        #expect(value.formatted(brl, locale: .ptBR) == "R$ 1.234,56")
        
        let other = NumberFormatter.currency(code: .usd, precision: 6, symbol: .usd)
        #expect(value.formatted(other, locale: .ptBR) == "USD 1.234,560000")

        
        let jpy = NumberFormatter.currency(code: .jpy, precision: 0)
        #expect(value.formatted(jpy, locale: .jaJP) == "¥1,235")
    }
    
    @Test("percent formatter")
    func testPercent() {
        let value = 0.25
        let formatter = NumberFormatter.percent
        #expect(value.formatted(formatter) == "25%")
    }
    
    @Test("decimal formatter")
    func testDecimal() {
        let value = 1234567.89
        let formatter = NumberFormatter.decimal
        #expect(value.formatted(formatter) == "1,234,567.89")
    }
    
    @Test("scientific formatter")
    func testScientific() {
        let value = 1_000_000.0
        let formatter = NumberFormatter.scientific
        #expect(value.formatted(formatter) == "1E6" || value.formatted(formatter) == "1e6") // Apple pode variar E ou e
    }
    
    @Test("currencyAccounting formatter (parentheses for negatives)")
    func testCurrencyAccounting() {
        let value: Double = -1000.0
        let formatter = NumberFormatter.currencyAccounting(code: .usd)
        formatter.locale = Locale(identifier: "en_US")
        #expect(value.formatted(formatter) == "($1,000.00)")
    }
    
    @Test("currencyISOCode formatter")
    func testCurrencyISOCode() {
        let value = 1000.0
        let formatter = NumberFormatter.currencyISOCode(code: .usd)
        formatter.locale = Locale(identifier: "en_US")
        // O formato exato pode variar entre sistemas
        let result = value.formatted(formatter) ?? ""
        #expect(result.contains("USD") && result.contains("1,000.00"))
    }
    
    @Test("spellOut formatter")
    func testSpellOut() {
        let value = 1234
        let formatter = NumberFormatter.spellOut
        formatter.locale = Locale(identifier: "en_US")
        #expect(value.formatted(formatter)?.contains("thousand") ?? false)
    }
    
    @Test("currencySpellOut formatter")
    func testCurrencySpellOut() {
        let value = 1234.56
        let formatter = NumberFormatter.currencySpellOut
        formatter.locale = .ptBR
        let formatted = formatter.string(from: NSNumber(value: value)) ?? ""
        #expect(formatted.contains("reais") && formatted.contains("centavos"))
    }
    
    @Test("currencySpellOut formatter")
    func testCurrencySpellOut2() {
        let value = 1.1
        let formatter = NumberFormatter.currencySpellOut
        formatter.locale = .ptBR
        let formatted = formatter.string(from: NSNumber(value: value)) ?? ""
        #expect(formatted.contains("real") && formatted.contains("centavo"))
    }
}
