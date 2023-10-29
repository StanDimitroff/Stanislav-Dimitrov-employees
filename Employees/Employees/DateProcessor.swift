//
//  DateProcessor.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

class DateProcessor {

  private lazy var dateFormatter = DateFormatter()

  private let dateFormat: String

  init(dateFormat: String) {
    self.dateFormat = dateFormat
  }

  func dateIntervalFor(start: String, end: String) -> DateInterval {
    let startDate = dateFrom(string: start)
    let endDate = dateFrom(string: end)

    return DateInterval(start: startDate, end: endDate)
  }

  func dateFrom(string: String) -> Date {
    dateFormatter.dateFormat = dateFormat

    return dateFormatter.date(from: string) ?? Date()
  }
}
