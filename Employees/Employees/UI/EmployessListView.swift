//
//  EmployessListView.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import SwiftUI

struct EmployessListView: View {

  @State private var showFileImporter = false
  @State private var showError = false

  @ObservedObject private var model: EmployeesModel

  init(model: EmployeesModel) {
    self.model = model
  }

  private let font = Font.system(size: 13)

  var body: some View {
    NavigationStack {
      HStack {
        Text("Employee ID #1")
        Text("Employee ID #2")
        Text("Project ID")
        Text("Days worked")
      }
      .font(font)
      .multilineTextAlignment(.center)
      .padding(.top)

      ScrollView {
        ForEach(model.records) { record in
          HStack(spacing: 80) {
            Text(record.employee1Id)
            Text(record.employee2Id)
            Text(record.projectId)
            Text(record.daysWorked)
          }
          .font(font)
          .multilineTextAlignment(.center)
        }
      }
      .navigationTitle(Text("Employees"))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button("Load CSV File") {
          showFileImporter.toggle()
        }
      }
      .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.commaSeparatedText]) { result in
        switch result {
        case let .success(url):
          model.loadCSVFile(from: url)
        case .failure:
          showError.toggle()
        }
      }
      .alert("Cannot import file", isPresented: $showError) {
        Button("OK", action: { })
      }
    }
  }
}

#Preview {
  EmployessListView(model: .init(csvParser: CSVParser(parsingDateFormat: ""), recordMatcher: RecordMatcher()))
}
