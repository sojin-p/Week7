//
//  AddView.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit

class AddView: BaseView {
    
    let photoImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let searchButton = { //노티피케이션용
        let view = UIButton()
        view.backgroundColor = .yellow
        return view
    }()
    
    let SearchProtocolButton = { //프로토콜용
        let view = UIButton()
        view.backgroundColor = .systemPink
        return view
    }()
    
    let dateButton = {
        let view = UIButton()
        view.backgroundColor = .blue
        view.setTitle(DateFormatter.today(), for: .normal)
        return view
    }()
    
    let titleButton = {
        let view = UIButton()
        view.backgroundColor = .systemMint
        view.setTitle("오늘의 사진", for: .normal)
        return view
    }()
    
    let contentButton = {
        let view = UIButton()
        view.backgroundColor = .gray
        view.setTitle("컨텐츠", for: .normal)
        return view
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(dateButton)
        addSubview(SearchProtocolButton)
        addSubview(titleButton)
        addSubview(contentButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
        
        SearchProtocolButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.leading.equalTo(photoImageView)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
    
}
