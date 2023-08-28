//
//  SearchView.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class SearchView: BaseView {
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "검색어를 입력해주세요"
        return view
    }()
    
    //컬렉션 뷰
    lazy var collectionView = { // lazy var: 레이아웃메서드 안에 self 시점 때문에
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()) //frame 중요!!!!!!!
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        view.collectionViewLayout = collectionViewLayout()
        return view
    }()
    
    override func configureView() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let size = UIScreen.main.bounds.width - 40 //self.frame.width
//        print(self.frame.width)
        layout.itemSize = CGSize(width: size / 4, height: size / 4)
        return layout
    }
    
}
