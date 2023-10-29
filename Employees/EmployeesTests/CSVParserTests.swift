//
//  CSVParserTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import XCTest
@testable import Employees

final class CSVParserTests: XCTestCase {

  func testLoadFileFromURLReturnsFileData() {
    let sut = CSVParser()

    let csvData = sut.loadFileData(from: fileURL())

    XCTAssertNotNil(csvData)
  }

  func testParseCSVDataReturnsRecords() {
    let sut = CSVParser()
    let csvData = sut.loadFileData(from: fileURL())!

    let actualRecords = sut.parse(csvData: csvData)

    XCTAssertEqual(actualRecords.count, 3)
  }

  private func fileURL() -> URL {
    let bundle = Bundle(for: CSVParserTests.self)
    let path = bundle.path(forResource: "records", ofType: "csv")!

    return URL(fileURLWithPath: path)
  }
}
