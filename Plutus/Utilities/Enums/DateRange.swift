//
//  DateRange.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import Foundation

enum DateRange: String, CaseIterable, Identifiable {
    case chocolate
    case vanilla
    case strawberry

    var id: String { self.rawValue }
}
