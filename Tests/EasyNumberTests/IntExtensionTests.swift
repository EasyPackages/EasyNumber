import Testing
import Foundation

@testable import EasyNumber

@Suite("Int")
struct IntExtensionTests {
    
    @Test("formatted(_:, locale:) with currency formatter")
    func testFormattedCurrency() {
        let value = 1000
        
        let usd = NumberFormatter.currency(code: .usd)
        #expect(value.formatted(usd, locale: Locale(identifier: "en_US")) == "$1,000.00")
        
        let brl = NumberFormatter.currency(code: .brl)
        #expect(value.formatted(brl, locale: Locale(identifier: "pt_BR")) == "R$ 1.000,00" || value.formatted(brl, locale: Locale(identifier: "pt_BR")) == "R$ 1.000,00")
        
        let jpy = NumberFormatter.currency(code: .jpy, precision: 0)
        #expect(value.formatted(jpy, locale: Locale(identifier: "ja_JP")) == "¥1,000")
    }
    
    @Test("formatted(_:, locale:) with decimal formatter")
    func testFormattedDecimal() {
        let value = 1234567
        let formatter = NumberFormatter.decimal
        #expect(value.formatted(formatter, locale: Locale(identifier: "en_US")) == "1,234,567")
        #expect(value.formatted(formatter, locale: Locale(identifier: "pt_BR")) == "1.234.567")
    }
    
    @Test("formatted(_:, locale:) with percent formatter")
    func testFormattedPercent() {
        let value = 42
        let formatter = NumberFormatter.percent
        // Int as percent is interpreted as 4200% (42.00 * 100) in NumberFormatter
        #expect(value.formatted(formatter, locale: Locale(identifier: "en_US")) == "4,200%")
    }
    
    @Test("formatted(_:, locale:) with spellOut formatter")
    func testFormattedSpellOut() {
        let value = 999
        let formatter = NumberFormatter.spellOut
        #expect(value.formatted(formatter, locale: Locale(identifier: "en_US")) == "nine hundred ninety-nine")
        #expect(value.formatted(formatter, locale: Locale(identifier: "pt_BR")) == "novecentos e noventa e nove")
    }
    
    @Test("double conversion works")
    func testDoubleConversion() {
        #expect(100.double == 100.0)
        #expect((-10).double == -10.0)
        #expect(Int.min.double == Double(Int.min))
        #expect(Int.max.double == Double(Int.max))
    }
    
    @Test("float conversion works")
    func testFloatConversion() {
        #expect(100.float == 100.0)
        #expect((-10).float == -10.0)
        #expect(Int.min.float == Float(Int.min))
        #expect(Int.max.float == Float(Int.max))
    }
    
    @Test("number conversion works")
    func testNSNumberConversion() {
        let value = 888
        let number = value.number
        #expect(number.intValue == 888)
        
        // Negative and zero
        #expect((-999).number.intValue == -999)
        #expect(0.number.intValue == 0)
    }
    
    @Test(".orZero")
    func orZero() {
        #expect(Optional<Int>.none.orZero == 0)
    }
}
