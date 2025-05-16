import Testing

@testable import EasyNumber

@Suite("CurrencyCode Enum Tests")
struct CurrencyCodeTests {

    @Test("All cases are unique")
    func testUniqueCodes() {
        let allCodes = CurrencyCode.allCases.map { $0.rawValue }
        let uniqueCodes = Set(allCodes)
        #expect(allCodes.count == uniqueCodes.count)
    }

    @Test("Each case matches its rawValue and is accessible by rawValue")
    func testCaseByRawValue() {
        for code in CurrencyCode.allCases {
            // The case's rawValue is correct and uppercased
            #expect(code.rawValue == code.rawValue.uppercased())
            
            // You can find the case by rawValue
            let found = CurrencyCode(rawValue: code.rawValue)
            #expect(found == code)
        }
    }

    @Test("CurrencyCode supports known major currencies")
    func testKnownCurrenciesPresent() {
        let majors: [String] = [
            "USD", "EUR", "BRL", "JPY", "CNY", "GBP", "AUD", "CAD",
            "CHF", "MXN", "ZAR", "RUB", "KRW", "SEK", "NOK", "DKK"
        ]
        let set = Set(CurrencyCode.allCases.map(\.rawValue))
        for code in majors {
            #expect(set.contains(code))
        }
    }
    
    @Test("CurrencyCode cases are never empty")
    func testCasesNonEmpty() {
        for code in CurrencyCode.allCases {
            #expect(!code.rawValue.isEmpty)
        }
    }

    @Test("Each case has the correct rawValue")
        func testCaseRawValues() {
            let expected: [CurrencyCode: String] = [
                .usd: "USD",
                .eur: "EUR",
                .brl: "BRL",
                .gbp: "GBP",
                .jpy: "JPY",
                .cny: "CNY",
                .inr: "INR",
                .aud: "AUD",
                .cad: "CAD",
                .chf: "CHF",
                .mxn: "MXN",
                .zar: "ZAR",
                .rub: "RUB",
                .krw: "KRW",
                .sek: "SEK",
                .nok: "NOK",
                .dkk: "DKK",
                .ars: "ARS",
                .clp: "CLP",
                .cop: "COP",
                .pen: "PEN",
                .thb: "THB",
                .idr: "IDR",
                .vnd: "VND",
                .php: "PHP",
                .hkd: "HKD",
                .sgd: "SGD",
                .myr: "MYR",
                .pln: "PLN",
                .czk: "CZK",
                .huf: "HUF",
                .ron: "RON",
                .try: "TRY",
                .egp: "EGP",
                .ngn: "NGN",
                .kes: "KES",
                .uah: "UAH",
                .ils: "ILS",
                .sar: "SAR",
                .aed: "AED",
                .bdt: "BDT",
                .lkr: "LKR",
                .pkr: "PKR",
                .mad: "MAD",
                .tnd: "TND",
                .qar: "QAR",
                .omr: "OMR",
                .bgn: "BGN",
                .rsd: "RSD",
                .hrk: "HRK",
                .isk: "ISK"
            ]
            
            for (currency, expectedRaw) in expected {
                #expect(currency.rawValue == expectedRaw)
            }
        }
}
