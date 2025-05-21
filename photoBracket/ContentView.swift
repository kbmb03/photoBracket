//
//  ContentView.swift
//  photoBracket
//
//  Created by Kaleb Davis on 5/21/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var pickerVM = PhotoPickerViewModel()
    @State private var showPhotoPicker = false
    
    var body: some View {
        VStack {
            Text("Photo Bracket!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 100)
            Button(action: {
                showPhotoPicker = true
                print("starting new bracket")
            }) {
                Text("Start New Bracket")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
            }
            Spacer()
        }
        .photosPicker(isPresented: $showPhotoPicker,
                      selection: $pickerVM.selectedItems,
                      matching: .images)
        .onChange(of: pickerVM.selectedItems) { oldItems, newItems in
            pickerVM.loadImages(from: newItems)
        }
                
    }
}
//
//#Preview {
//    ContentView()
//}
