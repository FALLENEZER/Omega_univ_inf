//
//  Feedback_country.swift
//  University_information
//
//  Created by Даниил Игумнов on 18.06.2024.
//
import SwiftUI
import RealmSwift


struct Feedback_country: View {
    
    @Binding var selected_country: Countries_list
    @Environment(\.dismiss) var dismiss
    @ObservedResults(UniverInfo.self) var univer
    @State var is_active = false
    @State var combinedData: [CombinedUniv] = []
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                .ignoresSafeArea(edges: .vertical)
            ScrollView {
                Text("Отзывы")
                    .font(.custom("Roboto", size: 20))
                
                ForEach(combinedData) { element in
                    cell(element, is_active)
                }
            }
        }
        .onAppear() {
            // Настройка внешнего вида navigation bar
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            Api().getUniv(name: selected_country.rawValue) { (vus) in
                let combined = vus.map { apiUniv in
                    CombinedUniv(
                        id: apiUniv.id,
                        apiData: apiUniv,
                        dbData: univer.first(where: { $0.name == apiUniv.name })
                    )
                }
                self.combinedData = combined
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem (placement: .topBarLeading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image("Back_custom_btn")
                            Text("\(selected_country.rawValue)")
                                .font(.custom("Roboto", size: 20))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
    
    func cell(_ element: CombinedUniv, _ is_active: Bool) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(element.apiData.name)")
                    .padding(.top, 10)
                Spacer()
                Button(action: { self.is_active.toggle() }) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                }
                .padding(.trailing, 20)
            }
            // Вывод данных из базы данных, если они существуют
            
            if let rate = element.dbData?.people_rate, !rate.isEmpty, let descr = element.dbData?.feedback, !descr.isEmpty {
                ForEach(Array(zip(rate, descr)), id: \.self.0) { (number, words) in
                    VStack {
                        Text("Оценка: \(number)")
                            .padding()
                        Text("Отзыв: \(words)")
                            .padding()
                    }
                }
            } else {
                Text("Оценки пока нету")
                    .padding(.vertical, 20)
            }
            
        }
        .frame(width: 336, alignment: .leading)
        //.frame(maxHeight: 136)
        .padding(.leading, 25)
        .font(.custom("Roboto", size: 20))
        .background(Color("Cell_color"))
        .clipShape(Rectangle())
        .foregroundStyle(.primary)
    }
    


}


