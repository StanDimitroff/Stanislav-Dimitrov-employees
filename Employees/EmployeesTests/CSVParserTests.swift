//
//  CSVParserTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import XCTest

class CSVParser {
  func loadFile(from url: URL) -> String? {
    let csvData = try? String(contentsOf: url, encoding: .utf8)
    
    return csvData
  }
}

final class CSVParserTests: XCTestCase {

  func testLoadFileFromURLReturnsFileData() {
    let bundle = Bundle(for: CSVParserTests.self)

    guard let path = bundle.path(forResource: "records", ofType: "csv") else {
      XCTFail("Cannot file find path")
      return
    }

    let fileURL = URL(fileURLWithPath: path)
    let sut = CSVParser()

    let csvData = sut.loadFile(from: fileURL)

    XCTAssertNotNil(csvData)
  }
}
