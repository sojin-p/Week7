//
//  BaseViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/28.
//

import UIKit
import SnapKit
import Kingfisher

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //순서 중요
        configureView()
        setConstraints()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        print("Base configureView")
    }
    
    func setConstraints() {
        print("Base setConstraints")
    }
    
    //얼럿을 자주 띄우면 여기에 넣어두 됨

}
