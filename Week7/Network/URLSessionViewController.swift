//
//  URLSessionViewController.swift
//  Week7
//
//  Created by 박소진 on 2023/08/30.
//

import UIKit

class URLSessionViewController: BaseViewController {
    
    var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
        
        //1. 환경설정
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main) //딜리게이트로 받겠다 / delegateQueue: 뷰에 얼만큼 받았는지 보여줄거라 main!
        
        //2. Task: 큰 사진이지만 data로 받을만해서 dataTask로! / 컴플리션은 중간에 받는 것 못하니까 없는 걸로!
        session.dataTask(with: url!).resume()
    }
    
}

extension URLSessionViewController: URLSessionDataDelegate { //중간중간 받는 것은 딜리게이트에 있다!
    
//    //서버에서 최초로 응답 받은 경우에 호출(상태코드 처리) didrec~ //100MB라면
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
//        print("RESPOINSE:", response)
//    }
//
    //서버에서 데이터 받을 때마다 반복적으로 호출 didrec~
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DATA:", data) //1600받았다 이런걸 계산해서 n% 받았다고 띄울 수 있음.
    }
    
    //서버에서 응답이 완료가 된 이후에 호출 - 더이상 받을 필요없다. complete~
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("END")
    }
}
