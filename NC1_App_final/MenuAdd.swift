//
//  MenuAdd.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/16/24.
//


import SwiftUI


struct MenuAdd: View {
    
    @Binding var showSheet: Bool
    @Binding var selectedDate: Date
    @Binding var evaluationState: OutputView.promiseState
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Text("다짐을 실천했나요?")
                    .foregroundStyle(Color.black)
                    .font(.system(size: 20, weight: .regular))
                    .padding(.vertical, 40)
                Button {
                    evaluationState = .afterSuccess
                    showSheet = false
                } label: {
                    Text("다짐 실천 성공🎉")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 20, weight: .bold))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 96)
                        .padding(.vertical, 27)
                        .background(Color(UIColor(hex: "3181F5")))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                }
            
                
                Button(action: {
                    evaluationState = .afterFailure
                    showSheet = false
                }, label: {
                    Text("다짐만..두였다🥟")
                        .foregroundStyle(Color.black)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.horizontal, 96)
                        .padding(.vertical, 27)
                        .background(Color(UIColor(hex: "F2F4F6")))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    
                })
            
            }
            
        }
    }
}
