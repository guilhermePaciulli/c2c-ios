//
//  ExpirationDateComponents.swift
//  C2C
//
//  Created by Guilherme Paciulli on 12/04/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

struct ExpirationDateComponents {
    var years: [String] = []
    var months: [String] = []
    var matrix: [[String]] = [[]]
    
    init() {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yy"
        (0...10).forEach { value in
            guard let y = Date().addYears(value: value) else { return }
            years.append(yearFormatter.string(from: y))
        }
        months = Calendar.current.shortMonthSymbols
        matrix = [months, years]
    }
    
    func get(_ component: Int, atIndex index: Int) -> String {
        return matrix[component][index]
    }
    
    func numberOfItems(inComponent component: Int) -> Int {
        return matrix[component].count
    }
    
    func numberOfComponents() -> Int {
        return matrix.count
    }
    
    func getDateFormatted(atMonth month: Int, year: Int) -> String {
        return months[month] + "/" + years[year]
    }
    
    func getIndexes(forString string: String) -> (month: Int?, year: Int?) {
        let splitted = string.split(separator: "/").map({ String($0) })
        guard let month = months.firstIndex(of: splitted[0]),
            let year = years.firstIndex(of: splitted[1]) else { return (nil, nil) }
        return (month, year)
    }
    
}

extension Date {
    
    func addYears(value: Int) -> Date? {
        var component = DateComponents()
        component.year = value
        let cal: Calendar = .current
        return cal.date(byAdding: component, to: self)
    }
    
}
