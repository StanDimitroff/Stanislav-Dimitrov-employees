//
//  CSVParserTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import XCTest
@testable import Employees

class CSVParser {

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

final class CSVParserTests: XCTestCase {

  func testLoadFileFromURLReturnsFileData() {
    let sut = CSVParser()

    let csvData = sut.loadFile(from: fileURL())

    XCTAssertNotNil(csvData)
  }

  func testParseCSVDataReturnsRecords() {
    let sut = CSVParser()
    let csvData = sut.loadFile(from: fileURL())!

    let actualRecords = sut.parse(csvData: csvData)

    XCTAssertEqual(actualRecords.count, 3)
  }

  private func fileURL() -> URL {
    let bundle = Bundle(for: CSVParserTests.self)
    let path = bundle.path(forResource: "records", ofType: "csv")!

    return URL(fileURLWithPath: path)
  }
}
