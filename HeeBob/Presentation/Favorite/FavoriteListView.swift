//
//  FavoriteListView.swift
//  HeeBob
//
//  Created by 산들 on 6/1/25.
//

import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @StateObject var favoriteViewModel = FavoriteViewModel()
    
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var router: NavigationRouter
    
    let transitionNamespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            FavoriteFilterControl(favoriteViewModel: favoriteViewModel)
            CardGrid(transitionNamespace: transitionNamespace, favorites: favoriteViewModel.favorites) { favorite in
                router.push(.favoriteMenuDetail(food: favorite.food))
            }
        }
        .onAppear {
            favoriteViewModel.listViewDidAppear(modelContext: modelContext)
        }
        .HBNavigationBar(
            leftView: {
                EmptyView()
            },
            centerView: {
                Text("찜한 메뉴")
                    .font(.hbSubtitle)
                    .foregroundStyle(Color.hbTextPrimary)
            },
            rightView: {
                Button {
                    router.push(.search)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.hbTextPrimary)
                        .frame(width: 24, height: 24)
                }
            }
        )
        .ignoresSafeArea(edges: .bottom)
        .hbBackground()
        .HBNavigationBarBackButtonHidden(false)
    }
}

struct CardGrid: View {
    let transitionNamespace: Namespace.ID
    
    var favorites: [Favorite]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible(), spacing: 6)
    ] // 열 혹은 행의 레이아웃 정의. flexible은 해당 열이나 행의 너비,높이가 유동적이게 지정.
    
    let didItemTap: (_ favorite: Favorite) -> Void
    
    init(transitionNamespace: Namespace.ID, favorites: [Favorite], didItemTap: @escaping (_ favorite: Favorite) -> Void) {
        self.transitionNamespace = transitionNamespace
        self.favorites = favorites
        self.didItemTap = didItemTap
    }
    
    var body: some View {
        ScrollView {
            Spacer()
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(favorites) { favorite in
                    Button {
                        didItemTap(favorite)
                    } label: {
                        FavoriteMenuCard(food: favorite.food, favorite: favorite)
                            .padding(.horizontal, 8)
                    }
                    .matchedTransitionSource(id: favorite.food.id, in: transitionNamespace)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#if DEBUG
struct FavoriteListView_Previews: PreviewProvider {
    struct TestView: View {
        @Namespace var namespace
        var body: some View {
            FavoriteListView(transitionNamespace: namespace)
        }
    }
    static var previews: some View {
        TestView()
    }
}
#endif
