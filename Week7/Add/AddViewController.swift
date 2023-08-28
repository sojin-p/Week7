//
//  ViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class AddViewController: BaseViewController {
    
    //1.
    let mainView = AddView()
    
    //2.
    override func loadView() { //viewDidLoad보다 먼저 호출됨, super 메서드 호출 XXX - 이유: 덮어질 수 있음
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil) //object: 유저인포로 값을 전달하니까 nil
        
    }
    
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        print("selectImageNotificationObserver")
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])
        
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
    }
    
    @objc func searchButtonClicked() {
        //반대로 add->search로 포스트
        let word = ["Apple", "Banana", "Cookie", "Cake", "Sky"]
        NotificationCenter.default.post(name: NSNotification.Name("RecommandKeyword"), object: nil, userInfo: ["word": word.randomElement()! ])
        
        present(SearchViewController(), animated: true)
    }
    
    override func configureView() { //addSubView
        super.configureView() //부모뷰 것도 호출하기
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        print("AddVC configureView")
    }

    override func setConstraints() { //제약조건
        super.setConstraints()
        
        print("AddVC setConstraints")
    }

}

