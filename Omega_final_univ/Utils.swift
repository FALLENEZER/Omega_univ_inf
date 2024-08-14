import Foundation
import SwiftUI
import RealmSwift

struct ViewModel {
    @StateObject var viewModel = UniversityViewModel()
}

// Модель для данных API
struct Univ: Decodable, Identifiable {
    var id = UUID()
    let web_pages: [String]
    let country: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case web_pages = "web_pages"
        case country = "country"
        case name = "name"
    }
}

// Комбинированная модель данных
struct CombinedUniv: Identifiable {
    var id = UUID()
    var apiData: Univ
    var dbData: UniverInfo?
}


// Класс для работы с API
class Api {
    func getUniv(name: String, completion: @escaping ([Univ]) -> ()){
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("No data received or data is nil")
                return
            }
            do {
                let all = try JSONDecoder().decode([Univ].self, from: data)
                DispatchQueue.main.async {
                    completion(all)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}

// Вспомогательная структура
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

// Структура для отображения строки данных
struct ShowRow: View {
    var univer = UniverInfo()
    var body: some View {
        HStack {
            Text(univer.name)
            Text(univer.rate)
            Text(univer.descr)
        }
    }
}

class UniversityViewModel: ObservableObject {
    private var realm: Realm

    @Published var universities: [UniverInfo] = []

    init() {
        // Инициализация Realm
        realm = try! Realm()

        // Загрузка данных из базы данных
        loadUniversities()
    }

    func loadUniversities() {
        let results = realm.objects(UniverInfo.self)
        universities = Array(results)
    }

    func addUniversity(name: String, country: String) {
        let university = UniverInfo()
        university.name = name
        university.country = country

        try! realm.write {
            realm.add(university)
        }

        // Обновление опубликованных данных
        loadUniversities()
    }
    
    func getOrAddUniversity(name: String, country: String) -> UniverInfo {
        if let existingUniversity = universities.first(where: { $0.name == name }) {
            return existingUniversity
        } else {
            addUniversity(name: name, country: country)
            return universities.first(where: { $0.name == name })!
        }
    }
}

// Перечисление стран
enum Countries_list: String {
    case Denmark = "Denmark"
    case France = "France"
    case Kazakhstan = "Kazakhstan"
}








