import Testing
import Foundation

@testable import EasyNumber

@Suite("Float")
struct FloatExtensionTests {
    @Test(".formatted(formatter:locale:)")
    func formatted() {
        #expect(Float(10.0).formatted(using: .decimal, locale: .ptBR) == "10")
        #expect(Float(12.1).formatted(using: .decimal, locale: .ptBR) == "12,1")
        #expect(Float(12.1).formatted(using: .decimal, locale: .enUS) == "12.1")
        #expect(Float(12.1).formatted(using: .currencySpellOut, locale: .enUS) == "twelve dollars and ten cents")
        #expect(Float(12.1).formatted(using: .currencySpellOut, locale: .ptBR) == "doze reais e dez centavos")
    }
    
    @Test(".double")
    func double() throws {
        #expect(Float(10).double == Double(10.0))
        #expect(abs(try #require(Float(10.1).double) - Double(10.1)) < 0.0001)
        #expect(abs(try #require(Float(1231.1231).double) - Double(1231.1231)) < 0.0001)
    }
    
    @Test(".int")
    func int() {
        #expect(Float(10).int == 10)
        #expect(Float(12.99999).int == 12)
        #expect(Float(12.9999999).int == 13)
        #expect(Float(12.000000000009).int == 12)
        #expect(Float(12.000000000001).int == 12)
    }
    
    @Test(".number")
    func number() throws {
        let number = try #require(Float(10.1).number)
        #expect((number as Any) is NSNumber)
        #expect(number.decimalValue == 10.1.number.decimalValue)
        #expect(abs(try #require(number.doubleValue) - Double(10.1)) < 0.0001)
        #expect(number.intValue == 10)
        #expect(number.floatValue == 10.1)
    }
    
    @Test(".orZero")
    func orZero() {
        #expect(Optional<Float>.none.orZero == 0)
    }
}
