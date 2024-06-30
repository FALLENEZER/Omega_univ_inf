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
                Text("Оставить отзыв")
                    .font(.custom("Roboto", size: 20))
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.white)
                    .frame(width: 295, height: 303)
                    .overlay(alignment: .topLeading) {
                        TextField("Введите отзыв", text: $feedback, axis: .vertical)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .padding(.trailing, 30)
                    }
                
                
                Segmented_picker(rate: $rate, options: [1, 2, 3, 4, 5])
                
                .padding(.vertical, 40)
                
                Button(action: { add_feedback(feedback, rate) }) {
                    Text("Отправить")
                }
                .frame(width: 264, height: 48)
                .font(.custom("Roboto", size: 16))
                .background(Color("Button_color"))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .foregroundStyle(.white)
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

struct Segmented_picker: View {
    @Binding var rate: Int
    let options: [Int]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(options, id: \.self) { option in
                VStack {
                    Button {
                        rate = option
                    } label: {
                        ZStack() {
                            Circle()
                                .foregroundStyle(rate == option ? .blue : .white)
                                .frame(width: 60)
                            Text("\(option)")
                                .foregroundStyle(rate == option ? .black : .gray)
                                .font(.custom("Roboto", size: 20))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    var selected_un = "МГУ"
    return Send_feedback(selected_un: selected_un)
}
