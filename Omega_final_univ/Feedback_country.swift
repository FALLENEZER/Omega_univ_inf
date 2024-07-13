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
    //@ObservedResults(Univer_inf.self) var univer
    //@ObservedResults(Country_inf.self) var country
    @State var is_active = false
    @State var vus: [Univ]

    
    var body: some View {
        ZStack {
            /*List(univers) { univ in
                Text("\(univ.alpha_two_code)")
            }
            .onAppear() {
                Api().getUniv { (univers) in
                    self.univers = univers ?? []
                }
            }
            .navigationTitle("Univers")
             */
            LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                .ignoresSafeArea(edges: .vertical)
            VStack {
                Text("Отзывы")
                    .font(.custom("Roboto", size: 20))
                
                ForEach(vus, id: \.name) { element in
                    /*ForEach(0..<element.feedback.count, id: \.self) { i in
                        cell(element, order: i, is_active)
                    }*/
                    Text("\(element.country)")
                    Text("\(element.name)")
                    Text("1")
                
                }
                .task {
                    do {
                        vus = try await Api().getUniv(url: "France")
                    } catch {
                        print("error")
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
                            HStack {
                                Image("Back_custom_btn")
                                Text("\(selected_country)")
                                    .font(.custom("Roboto", size: 20))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func cell(_ element: Univer_inf, order: Int, _ is_active: Bool) -> some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("\(element.name)")
                    .padding(.top, 10)
                Spacer()
                Button(action: { self.is_active.toggle() }) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                }
                .padding(.trailing, 20)
            }
            Text("Оценка: \(element.people_rate[order])")
                .padding(.vertical, 20)
            if is_active {
                Text("\(element.feedback[order])")
                    .padding(.bottom, 10)
            }
        }
        .frame(width: 336, alignment: .leading)
        .frame(maxHeight: 136)
        .padding(.leading, 25)
        .font(.custom("Roboto", size: 20))
        .background(Color("Cell_color"))
        .clipShape(Rectangle())
        .foregroundStyle(.primary)
    }
}

/*#Preview {
    @State var country = "USA"

    return Feedback_country(selected_country: $country, vus: Univ)
}
*/

