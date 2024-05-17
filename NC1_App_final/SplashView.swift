
//  SplashView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/19/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        
        Image("AppIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200) // 로고 이미지 크기 조절

    }
}
    
    #Preview {
        SplashView()
    }
