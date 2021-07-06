//
//  NetworkManager.swift
//  PenguinPay
//
//  Created by Bassant Ashraf on 05/07/2021.
//

import Foundation
import RxSwift

class APIRequest {

    let baseURL = URL(string: "https://openexchangerates.org/api/latest.json?app_id=bfd59595b1524ce98784a8d1a4bf6609")!
    var parameters = [String: String]()
    
    func request(with baseURL: URL) -> URLRequest {
           var request = URLRequest(url: baseURL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }
}

class APICalling {

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            
            let request = apiRequest.request(with: apiRequest.baseURL)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: ExchangeRateModel = try JSONDecoder().decode(ExchangeRateModel.self, from: data ?? Data())
                    observer.onNext( model as! T)
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


class FetchExchangeRatesUseCase {
    private let apiCalling = APICalling()
    private let disposeBag = DisposeBag()
    
    func fetch() -> Observable<ExchangeRateModel> {
    let request =  APIRequest()
        return self.apiCalling.send(apiRequest: request)
    }
}
