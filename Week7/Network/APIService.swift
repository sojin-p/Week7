//
//  APIService.swift
//  Week7
//
//  Created by 박소진 on 2023/08/30.
//

import Foundation
import Alamofire

class APIService {
    
//    init() { } //아무것도 안 적었을 때는 인터벌이라 여기저기서 다 씀
    private init() { }
    
    static let shared = APIService() //인스턴스 생성 방지
    
//    func callRequst() {
//
//        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/M66_JwstTomlinson_3521.jpg")
//        let request = URLRequest(url: url!)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            print(data)
//
//            let value = String(data: data!, encoding: .utf8) //data가 254 bytes로 되어있으니까 뭔지 몰라서.. 일단 눈으로 보고싶으면 스트링으로 변환해서 살펴보기
//            print(value)
//
//            print(response)
//            print(error)
//        }.resume()
//
//    }
    
    func callPhotoRequst(query: String, completionHandler: @escaping ([Photos]) -> Void ) {
        
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(text)&client_id=\(APIKey.unsplashAccessKey)") else { return }
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: SearchPhoto.self){ response in
            switch response.result {
            case .success(let value):
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }

        
    }
    
}
