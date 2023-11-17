//
//  ContentView.swift
//  TextReminderApp
//
//  Created by Shubhangini Sharma on 17/11/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = TextViewModel()

    var body: some View {
        VStack {
            Text("Text View")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.black)
            List {
                ForEach(viewModel.savedTexts, id: \.self) { text in
                    Text(text)
                        .contextMenu {
                            Button(action: { viewModel.deleteText(text) }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                            
                        }
                }
            }

            HStack {
                TextField("Enter text here", text: $viewModel.newText)
                Button("Save Text") {
                    viewModel.saveText()
                }
            }
            .padding()
        }
        .navigationTitle("Texts")
        .onAppear {
            viewModel.loadTexts()
            NotificationManager.shared.requestAuthorization()
            NotificationManager.shared.scheduleNotifications(with: viewModel.savedTexts)
        }
    }
}




#Preview {
    ContentView()
}
