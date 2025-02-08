//
//  ViewController.swift
//  1D1S
//
//  Created by 우진 on 1/31/25.
//

import UIKit
import SnapKit
import AVFoundation

class HomeViewController: UIViewController {
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setTitle("촬영하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubViews()
    }
}

private extension HomeViewController {
    @objc func openCamera() {
        // 카메라 권한 요청 및 확인
        AVCaptureDevice.requestAccess(for: .video) { isAuthorized in
            print("카메라 권한: \(isAuthorized)")
            return
        }
        
        // 카메라 열기
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.delegate = self
        self.present(pickerController, animated: true)
    }
}

extension HomeViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let _ = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        picker.dismiss(animated: true)
    }
}

private extension HomeViewController {
    func setupSubViews() {
        [cameraButton].forEach({ view.addSubview($0) })
        
        cameraButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.height.equalTo(70)
        })
    }
}

