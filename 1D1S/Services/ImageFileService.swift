//
//  ImageFileService.swift
//  1D1S
//
//  Created by 우진 on 2/9/25.
//

import UIKit

class ImageFileService {
    static let shared = ImageFileService()

    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
        
        do {
            try data.write(to: directory.appendingPathComponent(name))
            print("이미지 저장 성공")
        } catch let error {
            print("이미지 저장 오류 : \(error)")
        }
        
    }
    
    func getImage(named: String) -> UIImage? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return nil }
        let path = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(named).path
        let image = UIImage(contentsOfFile: path)
        return image
    }
}
