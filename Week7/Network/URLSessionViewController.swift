//
//  URLSessionViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/30.
//

import UIKit

class URLSessionViewController: BaseViewController {
    
    var session: URLSession!
    
    //진행률 1.
    var total: Double = 0
    //진행률 4.
    var buffer: Data? {
        didSet { //진행률 6. 안됨 버그를 찾자 - buffer 초기화를 안해서 옵셔널체이닝에 의한 에러 발생, 뷰딛롣에 초기화
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)"
            print(result)
            
            //"\(String(format: "%.1f", result * 100))%"
        }
    }
    
    let progressLabel = {
        let view = UILabel()
        view.backgroundColor = .brown
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data() //buffer?.append(data)가 실행되기 위해 초기화
        
        view.addSubview(progressLabel)
        view.addSubview(imageView)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        view.backgroundColor = .white
        
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        //1. 환경설정
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) //딜리게이트로 받겠다 / delegateQueue: 뷰에 얼만큼 받았는지 보여줄거라 main! 글로벌로 바꿨다면, imageview 처리 시 디스패치큐 메인어싱크에 담아야함
        
        //2. Task: 큰 사진이지만 data로 받을만해서 dataTask로! / 컴플리션은 중간에 받는 것 못하니까 없는 걸로!
        session.dataTask(with: url!).resume()
    }
    
    //카카오톡 사진 다운로드: 다운로드 중에 다른 채팅방으로 넘어가면? -> 계속 다운되게 해주고 있음. / 취소 버튼을 누르면? -> 중단해야 함
    //시점은 알아서 고려..(취소버튼을 만들든, 화면이 전환될 때든)
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //취소 액션(화면이 사라질 때 등)
        //리소스 정리, 실행중인 것도 무시
        session.invalidateAndCancel()
        
        //기다렸다가 리소스 끝나면 정리 (진행 중인 것까지만 받고 싶을 때)
        session.finishTasksAndInvalidate()
        
        //두 가지 동시에 사용은 안 함. 기획에 따라
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate { //중간중간 받는 것은 딜리게이트에 있다!
    
    //서버에서 최초로 응답 받은 경우에 호출(상태코드 처리) didrec~ //100MB라면
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("RESPOINSE:", response)
        
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            //진행률 2.
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)! //헤더 키 값을 가져오기
            return .allow
        } else {
            return .cancel
        }
    }

    //서버에서 데이터 받을 때마다 반복적으로 호출 didrec~
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //진행률 3. data 타입 확인 후 상단에 그 타입 변수 만들기
        print("DATA:", data) //1600받았다 이런걸 계산해서 n% 받았다고 띄울 수 있음.
        //진행률 5. 그 변수에 어팬드
        buffer?.append(data) //처음 buffer가 nil이면 옵셔널 체이닝에 의해 물음표 뒤 실행 X
        print(buffer, "버퍼값")
    }
    
    //서버에서 응답이 완료가 된 이후에 호출 - 더이상 받을 필요없다. complete~
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
        
        //진행률 7.
        if let error {
            print(error) //실패할 수 있으므로
        } else {
            guard let buffer = buffer else {
                print(error)
                return
            }
            imageView.image = UIImage(data: buffer) //data기반
        }
        
    }
}
