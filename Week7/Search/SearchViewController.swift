//
//  SearchViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView() //제어하게 될 때 인스턴스로 담는 게 접근하기 좋다.
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    
    var delegate: PassImageDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addObserver보다 post가 먼저 신호를 보내면 addObserver가 신호를 받지 못한다!!
//        NotificationCenter.default.addObserver(self, selector: #selector(recommandKeywordNotificationObserver), name: NSNotification.Name("RecommandKeyword"), object: nil)
        
    }

//    @objc func recommandKeywordNotificationObserver(notification: NSNotification) {
//        print("recommandKeywordNotificationObserver") //안 찍힘. 왜? 포스트가 먼저 실행되기 때문
//    }
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(imageList[indexPath.item])
        
        //Notification을 통한 값 전달
        //NSNotification.Name("SelectImage") 키 같은 것
        //NotificationCenter.default.post(name: .selectImage, object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "고래밥" ])
        
        //Protocol 값 전달
        delegate?.receiveData(name: imageList[indexPath.item])
        
        dismiss(animated: true)
    }
    
}
