//
//  HomeViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/31.
//

import UIKit

//1. didselect~를 VC에서 쓸 수 있게 값 전달
//AnyObject: 클래스에서만 프로토콜을 정의할 수 있도록 제약
protocol HomeViewProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath) //셀 선택했다는 것을 넘기기
}

class HomeViewController: BaseViewController {
    
    var list: Photo = Photo(total: 0, total_pages: 0, results: [])
    let mainView = HomeView()
    
    override func loadView() {
        //mainView.delegate = self //3.
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self, #function)
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        APIService.shared.callRequst(query: "sky") { photo in
            guard let photo = photo else {
                print("alert error")
                return
            }
            print("API END")
            self.list = photo
            
            //URLSession이 백그라운드로 동작하기 때문에 보라색 오류 뜸! - API 내부에 메인어싱크에 담기
            self.mainView.collectionView.reloadData()
        }
    }
    
    deinit {
        print("사라졌당", self)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return list.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .cyan
        
        //킹피셔 없이 이미지 불러오기 String -> url -> data -> image
        let thumb = list.results[indexPath.item].urls.thumb
        let url = URL(string: thumb) // 링크를 기반으로 이미지를 보여준다? -> 네트워크 통신이다!
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url!) //동기적으로 작동하는 코드
            DispatchQueue.main.async {
                cell.imageView.image = UIImage(data: data)
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
    
}


//4.
extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath, "잘 오나?")
        navigationController?.popViewController(animated: true)
    }
    
}
