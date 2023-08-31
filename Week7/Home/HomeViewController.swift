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
    
    override func loadView() {
        let view = HomeView() //접근할 일이 거의 없으니까 안에 넣기
        view.delegate = self //3.
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

//4.
extension HomeViewController: HomeViewProtocol {
    func didSelectItemAt(indexPath: IndexPath) {
        print(indexPath, "잘 오나?")
        navigationController?.popViewController(animated: true)
    }
    
}
