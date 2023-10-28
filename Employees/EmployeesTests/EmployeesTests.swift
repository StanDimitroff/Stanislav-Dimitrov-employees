//
//  EmployeesTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 28.10.23.
//

import XCTest
@testable import Employees

struct Employee {
  let id: Int
  let projects: [Int]
}

final class EmployeesTests: XCTestCase {

  private func testEmployees() -> [Employee] {
    [
      .init(id: 143, projects: [10, 22]),
      .init(id: 218, projects: [12, 9]),
      .init(id: 113, projects: [10, 17]),
      .init(id: 67, projects: [33]),
      .init(id: 218, projects: [9])
    ]
  }
}

