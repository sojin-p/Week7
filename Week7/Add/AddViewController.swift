//
//  ViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit
import SeSACFramework

//Protocol 값 전달 1. 형태 만들기
protocol PassDataDelegate {
    func receiveData(date: Date)
}

protocol PassImageDataDelegate {
    func receiveData(imageURLString: String)
}

//MARK: - AddViewController
class AddViewController: BaseViewController {
    
    //1.
    let mainView = AddView()
    
    let picker = UIImagePickerController()
    
    //2.
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 XXX - 이유: 덮어질 수 있음
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        APIService.shared.callRequst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil) //object: 유저인포로 값을 전달하니까 nil
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //remove하는 코드! 적절한 시점에 제거 필요 - 중복 제거, 여기가 좋은 자리는 아니긴 함
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    //MARK: - 함수
    @objc func selectImageNotificationObserver(notification: NSNotification) { 
        print("selectImageNotificationObserver")
//        print(notification.userInfo?["name"])
//        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        showAlert()
    }
    
    @objc func dateButtonClicked() {
        //Protocol 값 전달 5. delegate = self 시점...
        let vc = DateViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchProtocolButtonClicked() {
        
        let vc = SearchViewController()
        vc.delegate = self
        present(vc, animated: true)
        
    }
    
    @objc func titleButtonClicked() {
        
        let vc = TitleViewController()
        
        //Closure로 값 전달 (3)
        vc.completionHandler = { title, age, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("completionHandler", age, push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func contentButtonClicked() {
        let vc = ContentViewController()
        
        vc.completionHandler = { text in
            self.mainView.contentButton.setTitle(text, for: .normal)
        }
        present(vc, animated: true)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let getPhoto = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { action in
            self.getPhoto()
        }
        
        let searchWeb = UIAlertAction(title: "웹에서 검색하기", style: .default) { action in
            
            let vc = SearchViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        
        alert.addAction(getPhoto)
        alert.addAction(searchWeb)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
    }
    
    func getPhoto() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿") //설정페이지 열어주는 얼럿 등
            return
        }

        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    //MARK: - setUI
    override func configureView() { //addSubView
        super.configureView() //부모뷰 것도 호출하기
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.SearchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        mainView.titleButton.addTarget(self, action: #selector(titleButtonClicked), for: .touchUpInside)
        print("AddVC configureView")
        mainView.contentButton.addTarget(self, action: #selector(contentButtonClicked), for: .touchUpInside)
    }

    override func setConstraints() { //제약조건
        super.setConstraints()
        
        print("AddVC setConstraints")
    }

}

//MARK: - ImagePickerDelegate
extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //취소 버튼 클릭 시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    //사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.mainView.photoImageView.image = image
            dismiss(animated: true)
        }
        
    }
    
}

//MARK: - Protocol 값 전달 Extension
//Protocol 값 전달 4-1.
extension AddViewController: PassDataDelegate {
    
    //Protocol 값 전달 4-2.
    func receiveData(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
    
}

extension AddViewController: PassImageDataDelegate {
    
    func receiveData(imageURLString: String) {
        let url = URL(string: imageURLString)
        mainView.photoImageView.kf.setImage(with: url)
    }
}
