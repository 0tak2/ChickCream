//
//  MenuDetailView.swift
//  HeeBob
//
//  Created by 산들 on 5/31/25.
//
import SwiftUI
import SwiftData


struct FavoriteDetailView: View {
    let transitionNamespace: Namespace.ID
    
    let food: Food
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.modelContext) var modelContext
    @State var relatedFavorite: Favorite?
    
    var body: some View {
        MenuDetailContainer(food: food)
        .navigationTransition(
            .zoom(sourceID: food.id, in: transitionNamespace)
        )
        .hbBackground()
        .HBNavigationBar(centerView: {
            Text(food.title)
                .font(.hbSubtitle)
                .foregroundStyle(Color.hbTextPrimary)
        })
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    struct TestView: View {
        @Namespace var namespace
        var body: some View {
            FavoriteDetailView(transitionNamespace: namespace, food: .init(id: UUID(uuidString: "b9fbc325-de04-48a7-805b-000000000000")!, title: "김치찌개", uniquePoint: "새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰매콤새콤달큰", attribute: .init(id: UUID(), isPortable: true, isCookable: true, mainIngredient: .beefPork)))
        }
    }
    static var previews: some View {
        TestView()
    }
}
