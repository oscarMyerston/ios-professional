//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Oscar David Myerston Vega on 20/10/22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
