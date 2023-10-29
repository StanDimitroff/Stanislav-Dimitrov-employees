//
//  RecordPresentModel.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import Foundation

struct RecordPresentModel: Identifiable {
  let id = UUID()

  let employee1Id: String
  let employee2Id: String
  let projectId: String
  let daysWorked: String
}
