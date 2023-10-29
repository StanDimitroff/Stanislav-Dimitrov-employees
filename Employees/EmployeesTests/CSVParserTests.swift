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
    let sut = makeSUT(with: defaultDateFormat)

    let csvData = sut.loadFileData(from: fileURL(for: "records"))

    XCTAssertNotNil(csvData)
  }

  func testParseCSVDataWithDefaultDateFormatReturnsRecords() {
    let sut = makeSUT(with: defaultDateFormat)
    let csvData = sut.loadFileData(from: fileURL(for: "records"))!

    let actualRecords = sut.parse(csvData: csvData)

    XCTAssertEqual(actualRecords.count, 3)
  }

  func testParseCSVDataWithOtherDateFormatReturnsRecords() {
    let sut = makeSUT(with: defaultDateFormat)
    let csvData = sut.loadFileData(from: fileURL(for: "records-other"))!

    let actualRecords = sut.parse(csvData: csvData)

    XCTAssertEqual(actualRecords.count, 3)
  }

  private func makeSUT(with dateFormat: String) -> CSVParser {
    CSVParser(parsingDateFormat: dateFormat)
  }

  private func fileURL(for fileName: String) -> URL {
    let bundle = Bundle(for: CSVParserTests.self)
    let path = bundle.path(forResource: "records", ofType: "csv")!

    return URL(fileURLWithPath: path)
  }

  private var defaultDateFormat: String {
    "yyyy-MM-dd"
  }

  private var otherDateFormat: String {
    "DD/MM/YY"
  }
}
