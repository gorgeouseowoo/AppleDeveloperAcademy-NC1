//
//  OutputView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/16/24.
//

import SwiftUI
import Combine

struct OutputView: View {
    
    enum promiseState {
        case before
        case afterSuccess
        case afterFailure
        
        var returnString: String {
            switch self {
            case .before: return "으쌰쌰 다짐완료👀"
            case .afterSuccess: return "다짐 실천 성공🎉"
            case .afterFailure: return "다시 도전하면 돼👊"
            }
        }
        
        var placeholderFontColor: Color {
            switch self {
            case .before: return Color(UIColor(hex: "3181F5"))
            case .afterSuccess: return Color.white
            case .afterFailure: return Color.white
                //            default: return .white
            }
        }
        
        var placeHolderColor: Color {
            switch self {
            case .before: return Color(.white)
            case .afterSuccess: return Color(UIColor(hex: "3181F5"))
            case .afterFailure: return Color(UIColor(hex: "FF5099"))
            }
        }
        
        var boxBackgrounColor: Color {
            switch self {
                //Color 타입에 그라데이션 집어넣기
            case .before: return Color.blue
            case .afterSuccess: return Color.white
            case .afterFailure: return Color.white
            }
        }
        
        var backgroundTextColor: Color {
            switch self {
            case .before: return Color.white
            case .afterSuccess: return Color.black
            case .afterFailure: return Color.black
            }
        }
        
        var emojiShow: String {
            switch self {
            case .before: return "👀"
            case .afterSuccess: return "🎉"
            case .afterFailure: return "👊"
            }
        }
        
        
    }
        
    @State var evaluationState: promiseState = .before
    
    // DateFormatter : 날짜를 텍스트로 표현하기 위한 formatter => Text안에서 날짜 표현할 때 ,formatter를 dateFormatter로 지정해주면 되는 것임
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @State var promise: Promise
    
    @State var showSheet: Bool = false //sheet
    //    var placeholder: String //textfield의 Placeholder
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("\(promise.selectedDate, formatter: dateFormatter)")
                    .font(.system(size: 30, weight: .bold))
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Button(action: {
                                    showSheet = true
                                }, label: {
                                    Label("다짐 평가하기", systemImage: "checkmark")
                                })
                            } label: {
                                Image(systemName: "ellipsis.circle")
         
                            }
                        }
                    })
                
                VStack {
//                    HStack {
//                        Spacer()
//                        Text(evaluationState.emojiShow)
//                            .font(.system(size: 50, weight: .regular))
//                        Spacer()
//                    }
                    //흰 박스 + 파랑 버튼 VStack
                    VStack (spacing: 0) {
                        // 흰 박스 VStack
                        VStack(alignment: .leading, spacing: 12) {
                            Text("나는 오늘")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(evaluationState.backgroundTextColor)
                                .padding(.top,43)
                            HStack {
                                TextField("", text: $promise.title1)
                                    .foregroundColor(evaluationState.placeholderFontColor)
                                //                                .placeholder(when: promise.title1.isEmpty) {
                                //                                    Text(promise.title1)
                                //                                        .foregroundColor(evaluationState.placeholderFontColor)
                                //                                }
                                //
                                    .disabled(true)  //Textfield 비활성화
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 14)
                                    .background(
                                        evaluationState.placeHolderColor)
                                    .font(.system(size: 20, weight: .bold))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                Text("위해")
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundStyle(evaluationState.backgroundTextColor)
                            }
                            
                            TextField("", text: $promise.title2)
                                .foregroundColor(evaluationState.placeholderFontColor)
                                .disabled(true) //Textfield 비활성화
                                .padding(.horizontal, 6)
                                .padding(.vertical, 14)
                                .background(evaluationState.placeHolderColor)
                                .font(.system(size: 20, weight: .bold))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            Text("하겠다")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(evaluationState.backgroundTextColor)
                        }
                        .padding(.horizontal, 31)
                        .padding(.bottom, 31)
                        .background (evaluationState.boxBackgrounColor)
                        
                        // 버튼
                        HStack {
                            Spacer()
                            Text(evaluationState.returnString)
                                .font(.system(size: 20, weight: .black))
                                .foregroundStyle(Color.black)
                            Spacer()
                        }
                        .padding(.vertical, 27)
                        .background(Color.white)
                        
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 2,
                        x: 2, y: 2)
                    .padding(.horizontal, 22)
                    .padding(.top, 120)
                }
               
              
            }
            .background {
                switch evaluationState {
                case .before:
                    Color(UIColor(hex: "F2F4F6"))
                        .ignoresSafeArea()
                case .afterSuccess:
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "3181F5")), Color(UIColor(hex: "FFFFFF"))]),
                                   startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                case .afterFailure:
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "FF5099")), Color(UIColor(hex: "FFFFFF"))]),
                                   startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                }
            }
            
        }
        
        //sheet는 화면 전체에서 올라오는 것
        .sheet(isPresented: $showSheet) {
            MenuAdd(showSheet: $showSheet, selectedDate: $promise.selectedDate, evaluationState: $evaluationState)
                .presentationDetents([.medium])
        }
    }
}

//메뉴리스트
func edit() { }


#Preview {
    OutputView(promise: Promise(title1: "preview", title2: "preview2", selectedDate: Date()))
}


