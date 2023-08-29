//
//  ContentViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class ContentViewController: BaseViewController {
    
    let textView = {
        let view = UITextView()
        view.textAlignment = .center
        view.backgroundColor = .cyan
        return view
    }()
    
    //Closure로 값 전달 (1)
    var completionHandler: ((String) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) { //완벽하게 사라져야 did, 살짝만 밀어도 되는 건 will
        super.viewDidDisappear(animated)
        
        //Closure로 값 전달 (2) - 언제 전달할 지 시점 잡기
        completionHandler?(textView.text) //옵셔널 체이닝 ? 들어있으면 () 호출해라
        
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
    }
    
}
