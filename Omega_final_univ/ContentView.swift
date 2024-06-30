//
//  ContentView.swift
//  University_information
//
//  Created by Даниил Игумнов on 17.06.2024.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State private var selected_country = "Россия"
    @ObservedResults(Univer_inf.self) var univer
    @ObservedResults(Country_inf.self) var country
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                    .ignoresSafeArea(edges: .vertical)
                VStack {
                    Text("Добро пожаловать!")
                        .font(.custom("Roboto", size: 24))
                        .padding(.top, 90)
                        .foregroundStyle(.white)
                    Text("Выберите страну для начала работы !")
                        .font(.custom("Roboto", size: 20))
                        .padding(.top, 58)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                    
                    Picker("Choose an option", selection: $selected_country) {
                        ForEach(country, id: \.country) { element in
                            Text("\(element.country)")
                                .foregroundStyle(.white)
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("Текущая страна: \($selected_country.wrappedValue)") //TODO
                        .font(.custom("Roboto", size: 20))
                        .padding(.bottom, 18)
                        .foregroundStyle(.white)
                    Utils().Custom_buttons(button_naming: "Отзывы", where_to_go: Feedback_country(selected_country: $selected_country))
                    Utils().Custom_buttons(button_naming: "Выбрать", where_to_go: Choosing_univer(selected_country: $selected_country))
                        .padding(.top)
                }
                .foregroundStyle(.primary)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
