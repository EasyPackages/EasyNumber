![banner](./docs/banner.jpg)

[![Swift](https://github.com/EasyPackages/EasyNumber/actions/workflows/swift.yml/badge.svg)](https://github.com/EasyPackages/EasyNumber/actions/workflows/swift.yml)

**EasyNumber** is a robust, developer-friendly Swift package that makes working with numbers easy and locale-aware.
It includes utilities for parsing, formatting, and converting numbers from and to strings, handling currencies, percents, abbreviations (K, M, B), and even mathematical operations in user input.

## Features

- Format numbers (Int, Double, Float) as currency, decimal, scientific, percent, and spell-out styles
- Parse numbers from strings in various real-world formats (supports currencies, localized separators, and mathematical notations)
Supports input like "R$ 1.234,56", "10K", "5!", "2^8", "10%", "1,000円" and more
- Locale-aware: Handles grouping and decimal separators for any country
- Currency code and symbol helpers (ISO 4217)
- Lightweight, modular, and fully documented


## Examples

```swift
import EasyNumber

// Formatting
let value = 1999.99
value.formatted(.currency) // e.g., "$1,999.99" or "R$ 1.999,99" (locale-aware)
value.formatted(.decimal)  // "1,999.99"
value.formatted(.percent)  // "199,999%"

// Parsing from string
"R$ 1.234,56".double(locale: .ptBR) // 1234.56
"$1,000.25".double(locale: .enUS)   // 1000.25
"10K".int()                        // 10000
"5!".double()                      // 120.0
"2^8".double()                     // 256.0
"10%".double()                     // 0.10

// Currency code detection
let code = CurrencyCode(locale: Locale(identifier: "pt_BR")) // .brl

// or using also EasyCore
let code = CurrencyCode(locale: .ptBR) // .brl

// Flexible formatters
let formatter = NumberFormatter.currency(code: .usd)
let output = value.formatted(formatter, locale: .enUS) // "$1,999.99"
```

## Installation

Simply add a package to your project passing in https://github.com/EasyPackages/EasySymbol.

In your dependency you can add this in your Package.swift:

```swift
dependencies: [
    .package(
        url: "https://github.com/EasyPackages/EasyNumber.git",
        from: "1.0.0"
    )
]
```

In your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["EasyNumber"]
)
```

## Author

Created by [Paolo Prodossimo Lopes](https://github.com/PaoloProdossimoLopes)
Feel free to contribute, open issues, or suggest improvements.
