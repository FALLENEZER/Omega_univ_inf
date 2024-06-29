//
//  Feedback_country.swift
//  University_information
//
//  Created by Даниил Игумнов on 18.06.2024.
//

import SwiftUI
import RealmSwift

struct Feedback_country: View {
    @Binding var selected_country: String
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Univer_inf.self) var univer
    @ObservedResults(Country_inf.self) var country
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                .ignoresSafeArea(edges: .vertical)
            VStack {
                Text("\(selected_country)")
                    .font(.custom("Roboto", size: 20))
                    .foregroundStyle(.white)
                
                Text("Отзывы")
                    .font(.custom("Roboto", size: 20))
                
                ForEach(univer.filter({ $0.country == selected_country }), id: \.id) { element in
                    ForEach(0..<element.feedback.count, id: \.self) { i in
                        cell(element, order: i)
                    }
                }

            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("Back_custom_btn")
                        }
                    }
                }
            }
        }
    }
    
    func cell(_ element: Univer_inf, order: Int) -> some View {
        VStack(alignment: .leading) {
            Text("\(element.name)")
                .padding(.top, 10)
            Spacer()
            Text("Оценка: \(element.people_rate[order])")
            Spacer()
            Text("\(element.feedback[order])")
                .padding(.bottom, 10)
        }
        .frame(width: 336, height: 136)
        .font(.custom("Roboto", size: 16))
        .background(Color("Cell_color"))
        .clipShape(Rectangle())
        .foregroundStyle(.primary)
    }
}

#Preview {
    @State var country = "Беларусь"

    return Feedback_country(selected_country: $country)
}
