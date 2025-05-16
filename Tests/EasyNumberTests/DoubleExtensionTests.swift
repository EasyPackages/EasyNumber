import Testing
import Foundation

@testable import EasyNumber

@Suite("Double Extension Tests")
struct DoubleExtensionTests {
    
    @Test("formatted(_:, locale:) produces expected currency output")
    func testFormattedCurrency() {
        let value = 1234.56
        
        let usFormatter = NumberFormatter.currency(code: .usd)
        #expect(value.formatted(usFormatter, locale: Locale(identifier: "en_US")) == "$1,234.56")
        
        let brFormatter = NumberFormatter.currency(code: .brl)
        #expect(value.formatted(brFormatter, locale: Locale(identifier: "pt_BR")) == "R$ 1.234,56" || value.formatted(brFormatter, locale: Locale(identifier: "pt_BR")) == "R$ 1.234,56")
        
        let jpyFormatter = NumberFormatter.currency(code: .jpy, precision: 0)
        #expect(value.formatted(jpyFormatter, locale: Locale(identifier: "ja_JP")) == "¥1,235")
        
        let deFormatter = NumberFormatter.currency(code: .eur)
        #expect(value.formatted(deFormatter, locale: Locale(identifier: "de_DE"))?.contains("€") ?? false)
    }
    
    @Test("formatted(_:, locale:) handles decimal formatter")
    func testFormattedDecimal() {
        let value = 1234567.89
        let decimalFormatter = NumberFormatter.decimal
        #expect(value.formatted(decimalFormatter, locale: Locale(identifier: "en_US")) == "1,234,567.89")
        #expect(value.formatted(decimalFormatter, locale: Locale(identifier: "pt_BR")) == "1.234.567,89")
    }
    
    @Test("formatted(_:, locale:) handles percent formatter")
    func testFormattedPercent() {
        let value = 0.125
        let percentFormatter = NumberFormatter.percent
        #expect(value.formatted(percentFormatter, locale: Locale(identifier: "en_US")) == "12.5%")
    }
    
    @Test("formatted(_:, locale:) handles scientific formatter")
    func testFormattedScientific() {
        let value = 1_000_000.0
        let formatter = NumberFormatter.scientific
        let result = value.formatted(formatter, locale: Locale(identifier: "en_US")) ?? ""
        #expect(result.lowercased().starts(with: "1e"))
    }
    
    @Test("int: returns truncated Int value")
    func testIntConversion() {
        #expect(123.99.int == 123)
        #expect((-10.75).int == -10)
        #expect(0.0.int == 0)
        #expect(Double.nan.int == nil)
        #expect(Double.infinity.int == nil)
        #expect((-Double.infinity).int == nil)
    }
    
    @Test("float: returns Float equivalent")
    func testFloatConversion() {
        #expect(123.45.float == Float(123.45))
        #expect((-10.5).float == Float(-10.5))
        #expect(Double.infinity.float == Float.infinity)
        #expect(Double.nan.float?.isNaN ?? false)
    }
    
    @Test("number: returns NSNumber")
    func testNSNumberConversion() {
        let d: Double = 456.78
        let num: NSNumber = d.number
        #expect(num.doubleValue == 456.78)
        
        // Also test with negatives and zero
        #expect((-100.0).number.doubleValue == -100.0)
        #expect(0.0.number.doubleValue == 0.0)
    }
    
    @Test(".orZero")
    func orZero() {
        #expect(Optional<Double>.none.orZero == 0)
    }
}
