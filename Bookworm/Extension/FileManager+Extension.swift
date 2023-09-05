//
//  FileManager+Extension.swift
//  Bookworm
//
//  Created by Taekwon Lee on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func removeImageFromDocument(fileName: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "photo") ?? UIImage() }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName) // appendingPathComponent -> slash 역할
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path) ?? UIImage()
        } else {
            return UIImage(systemName: "photo") ?? UIImage()
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
}
