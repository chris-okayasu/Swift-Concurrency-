//
//  DoCatchTryThrows2.swift
//  SwiftConcurrency
//
//  Created by chris on 2024/12/16.
//

import SwiftUI


class DoCatchTryThrowsModelDataManager2: ObservableObject {
    let isActive: Bool = true
    
    func getTitle() -> (title: String? , error: Error?){
        if isActive {
            return ("ANOTHER TEXT 2", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2 () -> Result <String , Error> {
        if isActive {
            return .success("NEW TEXT 2")
        } else {
            return .failure(URLError(.unknown))
        }
    }
    
    //  try to return a string but it can return us an error (throws)
    func getTitle3 () throws -> String {
        if isActive{
            return "NEW TEXT 3"
        } else {
            throw URLError(.unknown)
        }
    }
    
    func getTitle4 () throws -> String {
        if isActive{
            return "FINAL TEXT 4"
        } else {
            throw URLError(.unknown)
        }
    }
}

class DoCatchTryThrowsModel2: ObservableObject {
    @Published var text = "Starting text 2."
    
    let manager = DoCatchTryThrowsModelDataManager2()
    
    func fetchTitle() {
        /*
         let returnedValue = manager.getTitle()
         if let returnedValue = returnedValue.title {
         self.text = returnedValue
         } else if let error = returnedValue.error{
         self.text = error.localizedDescription
         }
         */
        
        /*let result = manager.getTitle2()
         switch result {
         case .success(let title):
         self.text = title
         case .failure(let error):
         self.text = error.localizedDescription
         }*/
        // Using '?' means we don't care about error, the docatch is not requiered on this way
        let newTitle = try? manager.getTitle3()
        if let newTitle = newTitle {
            self.text = newTitle
        }
        
        /*do { if 1 'try' failure, the rest of them also does
            let newTitle = try manager.getTitle3()
            self.text = newTitle
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch let error {
            self.text = error.localizedDescription
        }*/
        
        /*do { how ever we can still use docatch like this but we never gonna get the catch error since we already said we do not care '?' about the error...
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch let error {
            self.text = error.localizedDescription
        }*/
    }
}


struct DoCatchTryThrows2: View {
    @StateObject private var viewModel = DoCatchTryThrowsModel2()
    
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
    DoCatchTryThrows2()
}
