//
//  SuccessView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/16/24.
//

import SwiftUI
import Combine

struct SuccessView: View {
    
    // DateFormatter : 날짜를 텍스트로 표현하기 위한 formatter => Text안에서 날짜 표현할 때 ,formatter를 dateFormatter로 지정해주면 되는 것임
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .long
        formatter.dateFormat = "YYYY년 MM월 dd일"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter
    }
    
    @Binding var selectedDate: Date
    
    @State var promise1: String = ""
    let textLimit1 = 15 //글자수 제한
    
    @State var promise2: String = ""
    let textLimit2 = 18 //글자수 제한

    
//    var placeholder: String //textfield의 Placeholder
    
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                
                Text("\(selectedDate, formatter: dateFormatter)")
                    .font(.system(size: 30, weight: .bold))
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Button(action: edit) {
                                    Label("다짐 수정하기", systemImage: "pencil")
                                }
                               
                                Button(role: .destructive, action: delete) {
                                    Label("평가 삭제하기", systemImage: "trash")
                                }
                                .foregroundColor(.red)
                            } label: {
//                                Image(systemName: "ellipsis.circle")
                                Image(systemName: "person")
                            }
                        }
                    })
                //흰 박스 + 파랑 버튼 VStack
                VStack (spacing: 0) {
                    
                    
                    // 흰 박스 VStack
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("나는 오늘")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color.black)
                            .padding(.top,43)
                       
                        
                        HStack {
//                            if promise1.isEmpty {
//                                            Text(placeholder)
//                                                .foregroundColor(Color.blue)
//                                                .padding(.horizontal, 6)
//                                                .padding(.vertical, 14)
//                                        }
                        
                            
                            TextField("", text: $promise1)
                                .placeholder(when: promise1.isEmpty) {
                                    Text("코딩 천재가 되기") .foregroundColor(Color(UIColor(hex: "FFFFFF")))
                                         }
                                .disabled(true)  //Textfield 비활성화
                                .padding(.horizontal, 6)
                                .padding(.vertical, 14)
                                .background(Color(UIColor(hex: "3181F5")))
                                .font(.system(size: 20, weight: .bold))
                              
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            
                            Text("위해")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(Color.black)
                        }
                        
                        TextField("", text: $promise2)
                            .placeholder(when: promise2.isEmpty) {
                                Text("콜렉션 타입을 블로그에 작성") .foregroundColor(Color(UIColor(hex: "FFFFFF")))
                                     }
                        //Textfield 비활성화
                            .disabled(true)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 14)
                            .background(Color(UIColor(hex: "3181F5")))
                            .font(.system(size: 20, weight: .bold))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        
                        
                        Text("하겠다")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(Color.black)
                        
                    }
                    .padding(.horizontal, 31)
                    .padding(.bottom, 31)
                    .background (Color.white)
                    
                    
                    // 버튼
                    
                    HStack {
                        Spacer()
                        Text("실천 성공! 축하해")
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
                .padding(.top, 150)
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "3181F5")), Color(UIColor(hex: "FFFFFF"))]),
                               startPoint: .bottom, endPoint: .top)
            }

            
        }
    }
    //메뉴리스트
    func edit() { }
    func delete() { }
}




#Preview {
    SuccessView(selectedDate: .constant(Date()))
}


