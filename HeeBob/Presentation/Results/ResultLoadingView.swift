//
//  ResultLoadingView.swift
//  HeeBob
//
//  Created by BoMin Lee on 6/4/25.
//

import SwiftUI
import Lottie

struct ResultLoadingView: View {
    @EnvironmentObject var router: NavigationRouter
    
    let userAnswer: UserAnswer
    
    var body: some View {
        ZStack {
            Color.hbBackground.edgesIgnoringSafeArea(.all)
            VStack(spacing: 64) {
                Text("메뉴 찾는 중...")
                    .font(.hbSubtitle)
                    .foregroundStyle(Color.hbTextPrimary)
                ZStack {
                    Image(.commonTextBackground)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 0)
                    LottieView(animation: .named("loading"))
                        .looping()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                try? await Task.sleep(nanoseconds: 5_000_000_000) // 5초
                router.pop() // 현재 뷰는 네비게이션 스택에서 제거
                router.push(.result(userAnswer: userAnswer))
            }
        }
    }
}

#Preview {
    ResultLoadingView(userAnswer: UserAnswer(isPortable: true, isCookable: true, mainIngredient: .beanTofuEgg))
}
