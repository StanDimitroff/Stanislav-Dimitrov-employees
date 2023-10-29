//
//  CSVParser.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

final class CSVParser {

  let dateProcessor = DateProcessor()

  func loadFile(from url: URL) -> String? {
    let csvData = try? String(contentsOf: url, encoding: .utf8)

    return csvData
  }

  func parse(csvData: String) -> [Record] {
    let rows = csvData.components(separatedBy: "\n")

    var records = [Record]()

    for row in rows {
      let columns = row.components(separatedBy: ", ")

      let employeeId = Int(columns[0]) ?? 0
      let projectId = Int(columns[1]) ?? 0
      let dateFrom = columns[2]
      let dateTo = columns[3].replacingOccurrences(of: "NULL", with: "")

      let dateInterval = dateProcessor.dateIntervalFor(start: dateFrom, end: dateTo)

      let record = Record(employeeId: employeeId, projectId: projectId, dateInterval: dateInterval)
      records.append(record)
    }

    return records
  }
}
