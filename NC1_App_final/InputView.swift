//
//  InputView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/16/24.
//


import SwiftUI
import SwiftData
import Combine

struct  InputView: View {
    @Environment(\.modelContext) private var context // CRUD 해주는 놈
//    @Environment(\.managedObjectContext) private var context
//    @FetchRequest(entity: Promise.entity(), sortDescriptors: []) var promiseList: FetchedResults<Promise> // @FetchRequest를 사용하여 데이터 가져오기

    
    // DateFormatter
    // 날짜를 텍스트로 표현하기 위한 formatter => Text안에서 날짜 표현할 때 ,formatter를 dateFormatter로 지정해주면 되는 것임
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter
    }
    
    // 자식뷰에서만 바뀌는 데이터 (날짜)
    @State var selectedDate: Date = Date()
    
    // listView와 연결할 바인딩 데이터
    // 날짜는 Promise 안에 이미 값을 넣어놨기 때문에 바인딩됨
//    @Binding var promises: [Promise]
    var promiseList: [Promise]
    
    @Binding var showInputSheet: Bool
    
    // Textfield 입력 데이터
    @State var promise1: String = ""
    let textLimit1 = 15 //글자수 제한
    
    @State var promise2: String = ""
    let textLimit2 = 18 //글자수 제한
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("\(selectedDate, formatter: dateFormatter)")
                    .font(.system(size: 30, weight: .bold))
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            DatePicker(selection: $selectedDate, displayedComponents: .date) {
//                                Image(systemName: "calendar")
                                Image(systemName: "person")
                            }
                            .datePickerStyle(.automatic)
                        }
                    })
                //흰 박스 + 파랑 버튼 VStack
                VStack (spacing: 0) {
                    // 흰 박스 VStack
                    VStack(alignment: .leading, spacing: 12) {
                        Text("나는 오늘")
                            .font(.system(size: 20, weight: .regular))
                            .padding(.top,43)
                        
                        HStack {
                            TextField("", text: $promise1)
                                .placeholder(when: promise1.isEmpty) {
                                    Text("최대 15글자 작성") .foregroundColor(Color(UIColor(hex: "ABB0BA")))
                                }
                                .padding(.horizontal, 6)
                                .padding(.vertical, 14)
                                .background(Color(UIColor(hex: "F2F4F6")))
                                .font(.system(size: 20, weight: .bold))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .onReceive(Just(promise1)) { _ in limitText1(textLimit1) }
                            
                            Text("위해")
                                .font(.system(size: 20, weight: .regular))
                        }
                        
                        TextField("", text: $promise2)
                            .placeholder(when: promise2.isEmpty) {
                                Text("최대 18글자 작성") .foregroundColor(Color(UIColor(hex: "ABB0BA")))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 14)
                            .background(Color(UIColor(hex: "F2F4F6")))
                            .font(.system(size: 20, weight: .bold))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onReceive(Just(promise2)) { _ in limitText2(textLimit2) }
                        
                        Text("하겠다")
                            .font(.system(size: 20, weight: .regular))
                        
                    }
                    .padding(.horizontal, 31)
                    .padding(.bottom, 31)
                    .background(Color.white)
                    
                    
                    // 버튼
                    
                    HStack {
                        Button(action: {
                            //romiseList.append(Promise(title1: promise1, title2: promise2, selectedDate: selectedDate))*/
                            showInputSheet = false
                            
                            //swiftdata
                            context.insert(Promise(title1: promise1, title2: promise2, selectedDate: selectedDate))
                        }, label: {
                            HStack {
                                Spacer()
                                Text("다짐하기")
                                    .font(.system(size: 20, weight: .black))
                                    .foregroundStyle(Color.white)
                                Spacer()
                            }
                            .padding(.vertical, 27)
                            .background(Color(UIColor(hex: "3181F5")))
                            
                        })
                    }
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 2,
                    x: 2, y: 2)
                .padding(.horizontal, 22)
                .padding(.top, 150)
            }
            .background(Color(UIColor(hex: "F2F4F6")))
        }
    }
    
    //글자 제한
    func limitText1(_ upper: Int) {
        if promise1.count > upper {
            promise1 = String(promise1.prefix(upper))
        }
    }
    
    func limitText2(_ upper: Int) {
        if promise2.count > upper {
            promise2 = String(promise2.prefix(upper))
        }
    }
    //메뉴리스트
    func add() { }
    func edit() { }
    func delete() { }
}


//#Preview {
//    InputView(promiseList: .constant([Promise(title1: "발리여행을 가기", title2: "하체 루틴 1시간을", selectedDate: Date.now)]), showInputSheet: .constant(false))
//}


