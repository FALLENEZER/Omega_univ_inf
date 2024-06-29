//
//  Choosing_univer.swift
//  University_information
//
//  Created by Даниил Игумнов on 18.06.2024.
//

import SwiftUI
import RealmSwift

struct Choosing_univer: View {
    @Binding var selected_country: String
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Univer_inf.self) var univer
    @ObservedResults(Country_inf.self) var country
    
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                    .ignoresSafeArea(edges: .vertical)
                
                VStack {
                    Text("\(selected_country)")
                        .font(.custom("Roboto", size: 20))
                    
                    VStack {
                        List(univer.filter({ $0.country == selected_country }), id: \.name) { element in
                            NavigationLink("\(element.name)", destination: Selected_un_inf(selected_un: element.name))
                        }
                    }
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

#Preview {
    @State var selected = "Россия"
    
    return Choosing_univer(selected_country: $selected)
}
