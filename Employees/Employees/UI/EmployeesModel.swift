//
//  EmployeesModel.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

final class EmployeesModel: ObservableObject {

  private let csvParser: CSVParser

  @Published private(set) var records = [Record]()

  init(csvParser: CSVParser) {
    self.csvParser = csvParser
  }

  func loadCSVFile(from url: URL) {
    guard let fileData = csvParser.loadFileData(from: url) else { return }
    let records = csvParser.parse(csvData: fileData)

    self.records = records
  }
}
