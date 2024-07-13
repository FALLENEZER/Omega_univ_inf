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

struct Univ: Codable {
    let name: String
    let web_pages: [String]
    let country: String
}

class Api {
    func getUniv(url: String) async throws -> [Univ] {
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=\(url)") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let univs = try JSONDecoder().decode([Univ].self, from: data)
        return univs
    }
}

enum Countries_list: String {
    case Russia = "Russia"
    case France = "France"
    case USA = "USA"
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
