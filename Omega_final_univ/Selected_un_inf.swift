//
//  Selected_un_inf.swift
//  University_information
//
//  Created by Даниил Игумнов on 21.06.2024.
//

import SwiftUI
import RealmSwift

struct Selected_un_inf: View {
    @State var selected_un: String
    @Environment(\.dismiss) var dismiss
    @ObservedResults(Univer_inf.self) var univer
    @ObservedResults(Country_inf.self) var country
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                .ignoresSafeArea(edges: .vertical)
            VStack {
                Text("\(selected_un)")
                    .font(.custom("Roboto", size: 20))
                    .foregroundStyle(.white)
                
                ShareLink(item: URL(string:"example.com")!) {
                    Text("Поделиться")
                        .frame(width: 264, height: 48)
                        .font(.custom("Roboto", size: 16))
                        .background(Color("Button_color"))
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .foregroundStyle(.white)
                }
                
                Utils().Custom_buttons(button_naming: "Отправить отзыв", where_to_go: Send_feedback(selected_un: selected_un))
            }
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    @State var selected_un = "МГУ"
    return Selected_un_inf(selected_un: selected_un)
}

