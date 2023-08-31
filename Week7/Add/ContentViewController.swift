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
    
    let sampleView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let indigoView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    //Closure로 값 전달 (1)
    var completionHandler: ((String) -> Void)?
    
    override func viewDidDisappear(_ animated: Bool) { //완벽하게 사라져야 did, 살짝만 밀어도 되는 건 will
        super.viewDidDisappear(animated)
        
        //Closure로 값 전달 (2) - 언제 전달할 지 시점 잡기
        completionHandler?(textView.text) //옵셔널 체이닝 ? 들어있으면 () 호출해라
        
    }
    
    deinit {
        print(self, "사라졌다")
    }
    
    func setAnimation() {
        //시작할 때 어떤 모습
        sampleView.alpha = 0
        indigoView.alpha = 0
        
        //끝날 때
        UIView.animate(withDuration: 1, delay: 2, options: .curveLinear) {
            self.sampleView.alpha = 1
            self.sampleView.backgroundColor = .green
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.indigoView.alpha = 1
            }
        }
        
//        UIView.animate(withDuration: 3) {
//            self.sampleView.alpha = 1
//        }
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(textView)
        view.addSubview(sampleView)
        view.addSubview(indigoView)
        setAnimation()
    }
    
    override func setConstraints() {
        
        sampleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        indigoView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view).offset(80)
        }
        
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
        }
        
    }
    
    //커스텀 뷰를 만들고 거기에 메서드 불러오면..!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.indigoView.alpha = 1.0
            UIView.animate(withDuration: 0.3) {
                self.indigoView.alpha = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            self.indigoView.alpha = 0.5
            UIView.animate(withDuration: 0.3) {
                self.indigoView.alpha = 1.0
            }
        }
    }
    
}
