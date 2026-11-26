//
//  PriceFormatter.swift
//  Preloved
//
//  Created by Elena Bandzaite on 26/11/2026.
//

import Foundation

struct PriceFormatter {
    private let locale: Locale

    init(locale: Locale = .current) {
        self.locale = locale
    }

    func string(from price: Double) -> String {
        price.formatted(.currency(code: "EUR").locale(locale))
    }
}
