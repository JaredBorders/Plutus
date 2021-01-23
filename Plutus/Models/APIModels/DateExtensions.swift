//
//  DateExtensions.swift
//  Plutus
//
//  Created by Musa Kokcen on 23.01.2021.
//

import Foundation

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
