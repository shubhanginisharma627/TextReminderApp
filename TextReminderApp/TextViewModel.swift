//
//  TextViewModel.swift
//  TextReminderApp
//
//  Created by Shubhangini Sharma on 17/11/23.
//
import Foundation

class TextViewModel: ObservableObject {
    @Published var savedTexts: [String] = []
    @Published var newText: String = ""

    func saveText() {
        savedTexts.insert(newText, at: 0) // Add new text at the top
        UserDefaults.standard.set(savedTexts, forKey: "SavedTexts")
        newText = ""
        NotificationManager.shared.scheduleNotifications(with: savedTexts)
    }

    func deleteText(_ text: String) {
        savedTexts.removeAll { $0 == text }
        
        updateUserDefaults()
    }

   

    func loadTexts() {
        if let loadedTexts = UserDefaults.standard.array(forKey: "SavedTexts") as? [String] {
            savedTexts = loadedTexts
        }
        updateTextOrder()
    }

    private func updateTextOrder() {
        updateUserDefaults()
    }

    private func updateUserDefaults() {
        UserDefaults.standard.set(savedTexts, forKey: "SavedTexts")
    }
}
