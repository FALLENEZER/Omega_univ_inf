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
    @ObservedResults(UniverInfo.self) var univer
    @State var combinedData: [CombinedUniv] = []

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                .ignoresSafeArea(edges: .vertical)
            VStack {
                Text("\(selected_un)")
                    .font(.custom("Roboto", size: 20))
                    .foregroundStyle(.white)
                
                /*ShareLink(item: URL(string: combinedData.first!.apiData.web_pages[0])) {
                 Text("Поделиться")
                 .frame(width: 264, height: 48)
                 .font(.custom("Roboto", size: 16))
                 .background(Color("Button_color"))
                 .clipShape(RoundedRectangle(cornerRadius: 50))
                 .foregroundStyle(.white)
                 }*/
                
                if let firstUniversity = combinedData.first,
                   let urlString = firstUniversity.apiData.web_pages.first,
                   let url = URL(string: urlString) {
                    VStack {
                        ShareLink(item: url)
                        
                        Text("Поделиться")
                            .frame(width: 264, height: 48)
                            .font(.custom("Roboto", size: 16))
                            .background(Color("Button_color"))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .foregroundStyle(.white)
                    }
                }
                
                Utils().Custom_buttons(button_naming: "Отправить отзыв", where_to_go: Send_feedback(selected_un: selected_un))
            }
            .onAppear() {
                Api().getUniv(name: selected_un) { (vus) in
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
            
        }
    }
}



