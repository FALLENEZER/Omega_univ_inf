//
//  Utils.swift
//  Omega_final_univ
//
//  Created by Даниил Игумнов on 28.06.2024.
//


import Foundation
import SwiftUI

struct Utils {
    func Custom_buttons(button_naming: String, where_to_go: some View) -> some View {
        NavigationLink(destination: where_to_go) {
            Text("\(button_naming)")
                .frame(width: 264, height: 48)
                .font(.custom("Roboto", size: 16))
                .background(Color("Button_color"))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .foregroundStyle(.white)
        }
    }
}

struct ShowRow: View {
    var univer = Univer_inf()
    var body: some View {
        HStack {
            Text(univer.name)
            Text(univer.rate)
            Text(univer.descr)
        }
    }

}
