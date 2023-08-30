//
//  SearchViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit
import Kingfisher

class SearchViewController: BaseViewController {
    
    let mainView = SearchView() //제어하게 될 때 인스턴스로 담는 게 접근하기 좋다.
    
    let imageList = ["pencil", "star", "person", "star.fill", "xmark", "person.circle"]
    var unsplashList: [Photos] = []
    
    var delegate: PassImageDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchBar.becomeFirstResponder() //키보드 바로 뜨기
        mainView.searchBar.delegate = self
        
    }
    
    func callRequest(query: String) {
        APIService.shared.callPhotoRequst(query: query) { data in
            self.unsplashList.append(contentsOf: data)
            self.mainView.collectionView.reloadData()
            print(self.unsplashList)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    //검색버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        unsplashList.removeAll()
        guard let query = searchBar.text else { return }
        callRequest(query: query)
        mainView.searchBar.resignFirstResponder() //키보드 내리기
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return unsplashList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: unsplashList[indexPath.item].urls.small)
        cell.imageView.kf.setImage(with: url)
//
//        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
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
