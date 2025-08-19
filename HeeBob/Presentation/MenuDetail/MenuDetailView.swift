//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//
import SwiftUI
import SwiftData


struct MenuDetailView: View {
    let food: Food
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.modelContext) var modelContext
    @State var relatedFavorite: Favorite?
    
    var body: some View {
        MenuDetailContainer(food: food)
        .hbBackground()
        .HBNavigationBar(centerView: {
            Text(food.title)
                .font(.hbSubtitle)
                .foregroundStyle(Color.hbTextPrimary)
        })
    }
}
