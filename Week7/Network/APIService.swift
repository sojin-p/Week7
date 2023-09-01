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
    
    func callRequst(query: String, completionHandler: @escaping (Photo?) -> Void) {

        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(APIKey.unsplashAccessKey)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10) //기본 60초인데 답답하니까 10초^^

        URLSession.shared.dataTask(with: request) { data, response, error in //data: 제이슨같은 , response 상태코드 서버상황, error 문제에 대한 것
            
            DispatchQueue.main.async { //VC에서 콜 할 때마다 이걸 사용해야하면, 내부에 구현하는게 나음(콜이 많은 경우)
                //1. error가 닐인지 아닌지 먼저 체크, 닐이면 성공이니까!
                if let error { //if let error = error { 와 같음
                    completionHandler(nil)
                    print(error)
                    return
                }
                
                //2. response에 대한 대응 (타입 캐스팅 필요)
                guard let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) else { //response를 HTTPURLResponse로 바꿨을 때 닐이 아니면 담아라
                    completionHandler(nil)
                    print(error) //Alert 또는 Do try Catch 등
                    return
                }
                
                //3. data대응
                guard let data = data else {
                    completionHandler(nil)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Photo.self, from: data)
                    completionHandler(result)
                    print(result)
                } catch {
                    completionHandler(nil)
                    print(error) //디코딩에러가 났을 때 어떤 키가 문제인지 종류 탐지 가능
                }
                
                //위가 너무 긴데..싶으면 try뒤에 ? 붙이기. 대신 이거는 그냥 nil만 주기 때문에 디버깅 영역에 오류 문구가 안뜸
                //let result = try? JSONDecoder().decode(, from: data)
            }
            
        }.resume()

    }
    
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

//퀵타입 쓰지 않고 직접 쓸 것만 정의
struct Photo: Codable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
