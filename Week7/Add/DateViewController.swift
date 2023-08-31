//
//  DateViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class DateViewController: BaseViewController {
    
    let mainView = DateView()
    
    //Protocol 값 전달 2. 값을 갖고 있는 곳에서 딜리게이트 변수 만들기
    var delegate: PassDataDelegate?
    
    override func loadView() {
        self.view = mainView
    }
    
    deinit {
        print(self, "사라졌다")
    }
    
    //Protocol 값 전달 3-1. 시점 잡기
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //Protocol 값 전달 3-2.
        delegate?.receiveData(date: mainView.picker.date) //mainView.picker.date 피커에서 선택한 날짜
    }
}

