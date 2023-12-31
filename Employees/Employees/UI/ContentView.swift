//
//  ContentView.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 28.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      EmployessListView(model: EmployeesModel(csvParser: .init(parsingDateFormat: "yyyy-MM-dd"), recordMatcher: .init()))
    }
}

#Preview {
    ContentView()
}
