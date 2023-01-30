//
//  ContentView.swift
//  API
//
//  Created by Ahsan Habib Swassow on 24/12/22.
//

struct Course : Hashable , Codable {
    let name : String
    let url : String
    let start_time : String
    let end_time : String
    let duration : String
    let site : String
    let in_24_hours : String
    let status: String
}

import SwiftUI
class ViewModel : ObservableObject {
    
    @Published var courses : [Course] = []
    
    func fetch() {
        guard let url = URL(string:  "https://kontests.net/api/v1/all") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            // convert to json
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.courses , id: \.self){ course in
                    HStack {
                        Image("")
                            .frame(width: 130,height: 70)
                            .background(Color.gray)
                        Text(course.name).bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Hello")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
