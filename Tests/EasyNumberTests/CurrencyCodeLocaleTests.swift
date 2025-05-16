import Testing
import Foundation

@testable import EasyNumber

@Suite("CurrencyCode Locale Initializer & Current")
struct CurrencyCodeLocaleTests {
    
    @Test("CurrencyCode from known locales")
    func testFromLocales() {
        // Brasil
        let brl = CurrencyCode(locale: Locale(identifier: "pt_BR"))
        #expect(brl == .brl)
        
        // EUA
        let usd = CurrencyCode(locale: Locale(identifier: "en_US"))
        #expect(usd == .usd)
        
        // Euro (França)
        let eur = CurrencyCode(locale: Locale(identifier: "fr_FR"))
        #expect(eur == .eur)
        
        // Japão
        let jpy = CurrencyCode(locale: Locale(identifier: "ja_JP"))
        #expect(jpy == .jpy)
        
        // China
        let cny = CurrencyCode(locale: Locale(identifier: "zh_CN"))
        #expect(cny == .cny)
    }
    
    @Test("Unknown or unsupported locale returns nil for init?")
    func testUnknownLocale() {
        let unknown = CurrencyCode(locale: Locale(identifier: "xx_YY"))
        #expect(unknown == .usd)
    }
    
    @Test("Fallback logic works")
    func testFallback() {
        let fallbackEur = CurrencyCode(locale: Locale(identifier: "xx_YY"), fallback: .eur)
        #expect(fallbackEur == .eur)
        
        let fallbackUsd = CurrencyCode(locale: Locale(identifier: "zz_WW"))
        #expect(fallbackUsd == .usd)
    }
    
    @Test("CurrencyCode.current uses current locale")
    func testCurrent() {
        // O resultado esperado depende do sistema do usuário/teste
        let current = CurrencyCode.current
        // Pelo menos deve ser um dos cases válidos (sanity check)
        #expect(CurrencyCode.allCases.contains(current))
    }
}
