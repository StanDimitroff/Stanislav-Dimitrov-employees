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

class EmployeeMatcher {
  func employeesWithCommonProjects(employees: [Employee]) -> [Employee] {
    let projectIDs = employees.flatMap { $0.projects }
    let groups = Dictionary(grouping: projectIDs, by: { $0 })
    let duplicates: [Int] = Array(groups.filter { $1.count > 1 }.keys)

    let filtered = employees.filter { $0.projects.contains(duplicates) }

    return filtered
  }
}

final class EmployeesTests: XCTestCase {

  func testLoadDataExtractsEmployeePairWithCommonProjects() {
    let employees = testEmployees()
    let sut = EmployeeMatcher()

    let employeesWithCommonProjects = sut.employeesWithCommonProjects(employees: employees)

    XCTAssertEqual(employeesWithCommonProjects.count, 2)
    XCTAssertEqual(employeesWithCommonProjects[0].id, 143)
    XCTAssertEqual(employeesWithCommonProjects[1].id, 113)
  }

  private func testEmployees() -> [Employee] {
    [
      .init(id: 143, projects: [10, 22]),
      .init(id: 218, projects: [12, 9]),
      .init(id: 113, projects: [10, 17]),
      .init(id: 67, projects: [33]),
      .init(id: 55, projects: [8])
    ]
  }
}
