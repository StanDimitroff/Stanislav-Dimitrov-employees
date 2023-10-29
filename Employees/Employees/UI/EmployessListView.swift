//
//  EmployessListView.swift
//  Employees
//
//  Created by Stanislav Dimitrov on 29.10.23.
//

import SwiftUI

struct EmployessListView: View {

  @State private var showFileImporter = false

  @ObservedObject private var model: EmployeesModel

  init(model: EmployeesModel) {
    self.model = model
  }

  var body: some View {
    NavigationStack {
      List {

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
        case let .failure(error):
          break
        }
      }
    }
  }
}

#Preview {
  EmployessListView(model: .init(csvParser: CSVParser()))
}
