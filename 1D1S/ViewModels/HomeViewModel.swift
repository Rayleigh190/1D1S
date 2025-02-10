//
//  Untitled.swift
//  1D1S
//
//  Created by 우진 on 2/9/25.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var didChangePhotoDatas: ((HomeViewModel) -> Void)?
    
    var closurePhoto: [PhotoData] {
        didSet {
            didChangePhotoDatas?(self)
        }
    }
    
    init() {
        closurePhoto = []
    }
    
    func fetchDatas() {
        let photo = DatabaseService.shared.readAll()
        let photoData: [PhotoData] = photo.map {
            let image = ImageFileService.shared.getImage(named: $0.fileName)
            return PhotoData(image: image, photo: $0)
        }
        closurePhoto = photoData
    }
    
    func saveData(image: UIImage) {
        let name = "IMG_\(Date())"
        let photo = Photo(fileName: name)
        DatabaseService.shared.save(photo)
        ImageFileService.shared.saveImage(image: image, name: name)
        fetchDatas()
        print("저장 완료")
    }
}
