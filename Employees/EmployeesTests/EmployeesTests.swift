//
//  EmployeesTests.swift
//  EmployeesTests
//
//  Created by Stanislav Dimitrov on 28.10.23.
//

import XCTest
@testable import Employees

struct Employee: Equatable {
  let id: Int
  let projects: [Int]
}

class EmployeeMatcher {
  func employeesWithCommonProjects(employees: [Employee]) -> [Employee] {
    let projectIDs: [Int] = employees.flatMap { $0.projects }
    let groups = Dictionary(grouping: projectIDs, by: { $0 })
    let duplicates: [Int] = Array(groups.filter { $1.count > 1 }.keys)

    let filtered = employees.filter { $0.projects.contains { element in
      return duplicates.contains(element)
    }}

    return filtered
  }
}

final class EmployeesTests: XCTestCase {

  func testLoadDataExtractsEmployeePairWithCommonProjects() {
    let employees = testEmployeesSinglePair()
    let sut = makeSUT()
    let expectedEmployees = [Employee(id: 143, projects: [10, 22]), Employee(id: 113, projects: [10, 17])]

    let actualEmployees = sut.employeesWithCommonProjects(employees: employees)

    XCTAssertEqual(expectedEmployees, actualEmployees)
  }

    func testLoadDataExtractsMultipleEmployeePairsWithCommonProjects() {
      let employees = testEmployeesMultiplePair()
      let sut = makeSUT()
      let expectedEmployees = [
        Employee(id: 143, projects: [10, 22]), 
        Employee(id: 218, projects: [12, 9]),
        Employee(id: 113, projects: [10, 17]),
        Employee(id: 55, projects: [8, 9])
      ]

      let actualEmployees = sut.employeesWithCommonProjects(employees: employees)

      XCTAssertEqual(expectedEmployees, actualEmployees)
    }

  private func makeSUT() -> EmployeeMatcher {
    return .init()
  }

  private func testEmployeesSinglePair() -> [Employee] {
    [
      .init(id: 143, projects: [10, 22]),
      .init(id: 218, projects: [12, 9]),
      .init(id: 113, projects: [10, 17]),
      .init(id: 67, projects: [33]),
      .init(id: 55, projects: [8])
    ]
  }

  private func testEmployeesMultiplePair() -> [Employee] {
    [
      .init(id: 143, projects: [10, 22]),
      .init(id: 218, projects: [12, 9]),
      .init(id: 113, projects: [10, 17]),
      .init(id: 67, projects: [33]),
      .init(id: 55, projects: [8, 9])
    ]
  }
}
