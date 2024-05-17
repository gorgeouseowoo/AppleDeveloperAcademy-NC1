//
//  ListView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/17/24.
//
//
import SwiftUI
import SwiftData


//struct Promise: Identifiable {
//    var id: UUID = UUID()
//    var title1: String
//    var title2: String
//    var selectedDate: Date
//}

//swiftData 모델 생성
@Model
class Promise: Identifiable {
    var id: UUID
    var title1: String
    var title2: String
    var selectedDate: Date
    
    init(id: UUID = UUID(), title1: String, title2: String, selectedDate: Date) {
        self.id = id
        self.title1 = title1
        self.title2 = title2
        self.selectedDate = selectedDate
    }
}


struct ListView: View {
    
    //splashView
    @State private var showMainView = false
    
    
    
    //swift data
    @Environment(\.modelContext) private var context
    @Query var promiseList: [Promise] = [] //뭘 넣어야 할까?
    
    //    @State var promiseList: [Promise] = [
    //        Promise(title1: "발리여행을 가기", title2: "하체 루틴 1시간을", selectedDate: Date.now),
    //        Promise(title1: "스위프트 천재가 되기", title2: "콜렉션 타입을 블로그에 정리", selectedDate: Date.now)
    //    ]
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        //        formatter.dateStyle = .long
        formatter.dateFormat = "YYYY.MM.dd"
        formatter.locale = Locale(identifier: "ko-KR")
        return formatter
    }
    @State var showInputSheet: Bool = false
    
    var body: some View {
        ZStack{
            if showMainView{
                NavigationStack {
                
                
                
                //리스트 화면에 보이는 데이터
                List {
                    ForEach(promiseList.indices, id:\.self) { index in
                        NavigationLink {
                            OutputView(promise: promiseList[index])
                            //하나만 남은 상황에서 삭제했을 때 오류가 난다
                        } label: {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(promiseList[index].title1)
                                        .foregroundStyle(.blue)
                                        .font(.system(size: 18, weight: .regular))
                                    Text("위해")
                                        .font(.system(size: 18, weight: .light))
                                }
                                HStack {
                                    Text(promiseList[index].title2)
                                        .foregroundStyle(.blue)
                                        .font(.system(size: 18, weight: .regular))
                                    Text("하겠다")
                                        .font(.system(size: 18, weight: .light))
                                }
                                Text("\(promiseList[index].selectedDate, formatter: dateFormatter)")
                                    .font(.system(size: 13, weight: .light))
                                
                                
                            }
                        }
                    }
                    //                    .onDelete(perform: removeRow)
                    .onDelete(perform: { indexSet in
                        print("indexset: \(indexSet)")
                        for i in indexSet {
                            context.delete(promiseList[i])
                        }
                        
                        //                        promiseList.remove(atOffsets: indexSet)
                    })
                    //
                    //
                }
                
                //                .scrollContentBackground(.hidden)
                .navigationTitle("다짐목록")
                .navigationBarTitleDisplayMode(.large)
                .toolbar  {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            showInputSheet = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        })
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
                
                .sheet(isPresented: $showInputSheet, content: {
                    InputView(promiseList: promiseList, showInputSheet: $showInputSheet)
                    // 다짐하기 버튼을 누르면 시트가 내려갔으면 좋겠음 -> 끝
                    // 입력 받은 값을 리스트로 보여주고 싶음
                    // 다짐 버튼을 눌렀을 때 입력받은 값들을 출력 print()
                    // 이전 화면에 표시
                    // 이전 화면에 리스트로 표시
                })
            }
            }
            else{
                SplashView().onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation{
                            showMainView = true
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    
    
}

#Preview {
    ListView()
}

