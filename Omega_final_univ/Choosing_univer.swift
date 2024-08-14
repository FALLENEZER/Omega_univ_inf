//
//  Choosing_univer.swift
//  University_information
//
//  Created by Даниил Игумнов on 18.06.2024.
//

import SwiftUI
import RealmSwift

struct Choosing_univer: View {
    @Binding var selected_country: Countries_list
    @Environment(\.dismiss) var dismiss
    @ObservedResults(UniverInfo.self) var univer
    @State var combinedData: [CombinedUniv] = []

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Pink_main_view"), Color.blue]), startPoint: .trailing, endPoint: .bottom)
                    .ignoresSafeArea(edges: .vertical)

                VStack {
                    Text("")

                    VStack {
                        List(combinedData.filter { $0.apiData.country == selected_country.rawValue }, id: \.apiData.name) { element in
                            NavigationLink(destination: {
                                Selected_un_inf(selected_un: UniversityViewModel().getOrAddUniversity(name: element.apiData.name, country: element.apiData.country).name)
                            }) {
                                Text("\(element.apiData.name)")
                            }
                        }
                    }
                    .onAppear() {
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
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
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

    /*private func getOrAddUniversityName(name: String, country: String) -> String {
        let viewModel = UniversityViewModel()
        let university = viewModel.getOrAddUniversity(name: name, country: country)
        return university.name
    }*/
}
