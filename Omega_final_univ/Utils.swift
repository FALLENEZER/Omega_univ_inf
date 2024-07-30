import Foundation
import SwiftUI

struct Utils {
    func Custom_buttons(button_naming: String, where_to_go: some View) -> some View {
        NavigationLink(destination: where_to_go) {
            Text("\(button_naming)")
                .frame(width: 264, height: 48)
                .font(.custom("Roboto", size: 16))
                .background(Color("Button_color"))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .foregroundStyle(.white)
        }
    }
}

struct ShowRow: View {
    var univer = Univer_inf()
    var body: some View {
        HStack {
            Text(univer.name)
            Text(univer.rate)
            Text(univer.descr)
        }
    }
}

struct Univ: Decodable, Identifiable {
    var id = UUID()
    let web_pages: [String]
    let country: String
    let name: String
}

class Api {
    func getUniv(name: String, completion: @escaping ([Univ]) -> ()){
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=\(String(describing: name))") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(response ?? "hz")
            print(error!)
            
            let all = try! JSONDecoder().decode([Univ].self, from: data!)
            DispatchQueue.main.async {
                completion(all)
            }
        } .resume()
    }
}

enum Countries_list: String {
    case Denmark = "Denmark"
    case France = "France"
    case Kazakhstan = "Kazakhstan"
}


