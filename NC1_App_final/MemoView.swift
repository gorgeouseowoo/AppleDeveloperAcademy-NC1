//
//  MemoView.swift
//  NC1_App_final
//
//  Created by KIM SEOWOO on 4/18/24.
//

import SwiftUI
import PhotosUI

struct MemoView: View {
    
    @State var selectedItemList = [PhotosPickerItem]()
    @State var selectedImageList = [UIImage]()
    
    var body: some View {
        PhotosPicker(selection: $selectedItemList, photoLibrary: .shared()) {
            if selectedImageList.isEmpty {
                ZStack{
                    RoundedRectangle(cornerRadius: 10.0)
                    Image(systemName: "plus")
                }
                .padding()
            }
            else {
                TabView {
                    ForEach(selectedImageList, id: \.self) { item in
                        Image(uiImage: item)
                            .resizable()
                            .scaledToFill()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
            
        }
        .onChange(of: selectedItemList) { oldValue, newValue in
            Task {
                var newImageList: [UIImage] = []
                for item in selectedItemList {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            newImageList.append(uiImage)
                        }
                    }
                }
                selectedImageList = newImageList
                print(selectedImageList)
            }
            
        }
    }
}

#Preview {
    MemoView()
}
