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
    
    private let viewModel = HomeViewModel()
    private var photoDatas: [PhotoData] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubViews()
        setBindings()
        viewModel.fetchDatas()
    }
    
    func setBindings() {
        viewModel.didChangePhotoDatas = { viewModel in
            self.photoDatas = viewModel.closurePhoto.reversed()
            self.tableView.reloadData()
        }
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
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        picker.dismiss(animated: true)
        viewModel.saveData(image: image)
    }
}

extension HomeViewController: UITableViewDataSource & UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.image.image = photoDatas[indexPath.row].image
        cell.dateLabel.text = photoDatas[indexPath.row].photo.date.description
        return cell
    }
}

private extension HomeViewController {
    func setupSubViews() {
        [tableView, cameraButton].forEach({ view.addSubview($0) })
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cameraButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.height.equalTo(50)
        }
    }
}

