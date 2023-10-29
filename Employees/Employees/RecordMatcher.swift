//
//  RecordMatcher.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

class RecordMatcher {
  func recordsWithCommonProjectsForPeriod(records: [Record]) -> [Int: [Record]] {
    let recordGroupsByProject = Dictionary(grouping: records, by: { $0.projectId })
    let recordGroupsWithMoreThanOneProject = recordGroupsByProject.filter { $0.value.count > 1 }

    let isPairWorkedAtTheSameTime: ([Record]) -> Bool = { records in
      guard records.count > 1 else { return false }

      return records[0].dateInterval.intersects(records[1].dateInterval)
    }

    var filteredByPeriodIntersection = [Int: [Record]]()
    for (key, value) in recordGroupsWithMoreThanOneProject {
      if isPairWorkedAtTheSameTime(value) {
        filteredByPeriodIntersection[key] = value
      }
    }

    return filteredByPeriodIntersection
  }
}
