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
    func receiveData(name: String)
}

class AddViewController: BaseViewController {
    
    //1.
    let mainView = AddView()
    
    //2.
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 XXX - 이유: 덮어질 수 있음
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassOpenExample.publicExample()
        ClassPublicExample.publicExample()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil) //object: 유저인포로 값을 전달하니까 nil
        
        sesacShowActibityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
//        sesacShowAlert(title: <#T##String#>, message: <#T##String#>, buttonTitle: <#T##String#>, buttonAction: <#T##(UIAlertAction) -> Void#>)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //remove하는 코드! 적절한 시점에 제거 필요 - 중복 제거, 여기가 좋은 자리는 아니긴 함
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) { 
        print("selectImageNotificationObserver")
//        print(notification.userInfo?["name"])
//        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        //반대로 add->search로 포스트는 불가(addObserver가 먼저 등록되어야 하기 때문)
//        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
//        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()! ])
        
        navigationController?.pushViewController(SearchViewController(), animated: true)
//        present(SearchViewController(), animated: true)
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
    
    override func configureView() { //addSubView
        super.configureView() //부모뷰 것도 호출하기
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        mainView.SearchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonClicked), for: .touchUpInside)
        print("AddVC configureView")
    }

    override func setConstraints() { //제약조건
        super.setConstraints()
        
        print("AddVC setConstraints")
    }

}

//Protocol 값 전달 4-1.
extension AddViewController: PassDataDelegate {
    
    //Protocol 값 전달 4-2.
    func receiveData(date: Date) {
        mainView.dateButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
    
}

extension AddViewController: PassImageDataDelegate {
    func receiveData(name: String) {
        mainView.photoImageView.image = UIImage(systemName: name)
    }
}
