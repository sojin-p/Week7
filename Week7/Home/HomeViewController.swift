//
//  HomeViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/31.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func loadView() {
        let view = HomeView() //접근할 일이 거의 없으니까 안에 넣기
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    deinit {
        print("사라졌당", self)
    }

}
