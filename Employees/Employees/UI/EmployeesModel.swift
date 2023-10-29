//
//  EmployeesModel.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

final class EmployeesModel: ObservableObject {

  private let csvParser: CSVParser
  private let recordMatcher: RecordMatcher

  @Published private(set) var records = [RecordPresentModel]()

  init(csvParser: CSVParser, recordMatcher: RecordMatcher) {
    self.csvParser = csvParser
    self.recordMatcher = recordMatcher
  }

  func loadCSVFile(from url: URL) {
    guard let fileData = csvParser.loadFileData(from: url) else { return }
    let records = csvParser.parse(csvData: fileData)
    
    matchRecords(records)
  }

  private func matchRecords(_ records: [Record]) {
    let matchedRecords: [Int: [Record]] = recordMatcher.recordsWithCommonProjectsForPeriod(records: records)

    var presentModels = [RecordPresentModel]()

    for (key, value) in matchedRecords {
      let recordPair = value
      let employee1Id = String(recordPair[0].employeeId)
      let employee2Id = String(recordPair[1].employeeId)
      let projectId = String(key)

      let employee1Interval = recordPair[0].dateInterval
      let employee2Interval = recordPair[1].dateInterval

      let intervalIntersection = employee1Interval.intersection(with: employee2Interval) ?? .init()

      let days = Calendar.current.dateComponents([.day], from: intervalIntersection.start, to: intervalIntersection.end)
      let daysWorked = String(days.day ?? 0)

      let presentModel = RecordPresentModel(
        employee1Id: employee1Id,
        employee2Id: employee2Id,
        projectId: projectId,
        daysWorked: daysWorked
      )

      presentModels.append(presentModel)

    }
    self.records = presentModels
  }
}
