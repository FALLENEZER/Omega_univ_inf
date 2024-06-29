//
//  Send_feedback.swift
//  University_information
//
//  Created by Даниил Игумнов on 22.06.2024.
//

import SwiftUI
import RealmSwift

struct Send_feedback: View {
    @State var selected_un: String
    @State var feedback: String = ""
    @State var rate: Int = 5
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
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundStyle(.white)
                        .frame(width: 295, height: 303)
                    TextField("Введите отзыв", text: $feedback)
                        .padding(.leading, 66)
                }
                
                Picker("", selection: $rate) {
                    ForEach(1..<6) { element in
                        Text("\(element)")
                    }
                }
                .pickerStyle(.segmented)
                Button(action: { add_feedback(feedback, rate) }) {
                    Text("Отправить")
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    func add_feedback(_ feedback: String, _ rate: Int) {
        let realm = try! Realm()
        
        if let university = realm.objects(Univer_inf.self).first(where: {$0.name == selected_un}) {
            try! realm.write {
                university.feedback.append(feedback)
                university.people_rate.append("\(rate)")
            }
        }
    }
}

#Preview {
    var selected_un = "МГУ"
    return Send_feedback(selected_un: selected_un)
}
