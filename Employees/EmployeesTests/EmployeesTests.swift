//
//  EmployeesTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 28.10.23.
//

import XCTest
@testable import Employees

struct Record: Equatable {
  let employeeId: Int
  let projectId: Int
  let dateInterval: DateInterval
}

class RecordMatcher {
  func recordsWithCommonProjects(records: [Record]) -> [Int: [Record]] {
    let groupsByProject = Dictionary(grouping: records, by: { $0.projectId })
    let groupsWithMoreThanOneValue = groupsByProject.filter { $0.value.count > 1 }

    return groupsWithMoreThanOneValue
  }
}

class DateProcessor {

  private lazy var dateFormatter = DateFormatter()

  func dateIntervalFor(start: String, end: String) -> DateInterval {
    let startDate = dateFrom(string: start)
    let endDate = dateFrom(string: end)

    return DateInterval(start: startDate, end: endDate)
  }

  func dateFrom(string: String) -> Date {
    dateFormatter.dateFormat = "yyyy-MM-dd"

    return dateFormatter.date(from: string) ?? Date()
  }
}

final class EmployeesTests: XCTestCase {

  private lazy var dateIntervals = createDateIntervals()

  func testLoadDataExtractsRecordPairWithCommonProjects() {
    let records = [
      Record(employeeId: 143, projectId: 10, dateInterval: dateInterval(at: 0)),
      Record(employeeId: 333, projectId: 12, dateInterval: dateInterval(at: 3)),
      Record(employeeId: 113, projectId: 10, dateInterval: dateInterval(at: 4)),
      Record(employeeId: 218, projectId: 12, dateInterval: dateInterval(at: 2)),
      Record(employeeId: 111, projectId: 9, dateInterval: dateInterval(at: 5))
    ]

    let sut = makeSUT()

    let expectedRecords = [
      10:
      [
        Record(employeeId: 143, projectId: 10, dateInterval: dateInterval(at: 0)),
        Record(employeeId: 113, projectId: 10, dateInterval: dateInterval(at: 4))
      ],
      12:
      [
        Record(employeeId: 333, projectId: 12, dateInterval: dateInterval(at: 3)),
        Record(employeeId: 218, projectId: 12, dateInterval: dateInterval(at: 2)),
      ]
    ]

    let actualRecords = sut.recordsWithCommonProjects(records: records)

    XCTAssertEqual(expectedRecords, actualRecords)
  }

  private func makeSUT() -> RecordMatcher {
    return .init()
  }

  private func createDateIntervals() -> [DateInterval] {
    let processor = DateProcessor()
    let dates = [
      (start: "2012-04-16", end: ""),
      (start: "2012-05-18", end: "2012-05-20"),
      (start: "2011-06-21", end: "2017-04-06"),
      (start: "2015-03-12", end: "2015-05-11"),
      (start: "2019-01-18", end: "2022-02-19"),
      (start: "2010-07-14", end: "2013-09-29"),
      (start: "2019-01-18", end: "2023-08-17"),
      (start: "2008-06-15", end: "2010-11-18"),
      (start: "2009-12-01", end: "2014-10-25")
    ]

    var dateIntervals = [DateInterval]()
    dates.forEach { date in
      dateIntervals.append(processor.dateIntervalFor(start: date.start, end: date.end))
    }

    return dateIntervals
  }

  private func dateInterval(at index: Int) -> DateInterval {
    dateIntervals[index]
  }
}
