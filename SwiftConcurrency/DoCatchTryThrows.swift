//
//  DoCatchTryThrows.swift
//  SwiftConcurrency
//
//  Created by chris on 2024/12/16.
//

import SwiftUI


class DoCatchTryThrowsModelDataManager: ObservableObject {
    func getTitle() -> String {
        return "ANOTHER TEXT"
    }
}

class DoCatchTryThrowsModel: ObservableObject {
    @Published var text = "Starting text."
    
    let manager = DoCatchTryThrowsModelDataManager()
    
    func fetchTitle() {
        let newTitle = manager.getTitle()
        self.text = newTitle
    }
}

struct DoCatchTryThrows: View {
    @StateObject private var viewModel = DoCatchTryThrowsModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrows()
}
