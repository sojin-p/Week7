//
//  SearchCollectionViewCell.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        contentView.addSubview(imageView) //contentView!!!!!
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
