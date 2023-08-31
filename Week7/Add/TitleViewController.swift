//
//  TitleViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {
    
    let textField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        view.textAlignment = .center
        return view
    }()
    
    //Closure로 값 전달 (1)
    var completionHandler: ((String, Int, Bool) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) { //완벽하게 사라져야 did, 살짝만 밀어도 되는 건 will
        super.viewDidDisappear(animated)
        
        //Closure로 값 전달 (2) - 언제 전달할 지 시점 잡기
        completionHandler?(textField.text!, 100, true) //옵셔널 체이닝 ? 들어있으면 () 호출해라
        
    }
    
    deinit {
        print(self, "사라졌다")
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
    }
    
    @objc func doneButtonClicked() {
        print(#function)
        completionHandler?(textField.text!, 90, false)
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
}
