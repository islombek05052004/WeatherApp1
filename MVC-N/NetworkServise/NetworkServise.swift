//
//  NetworkServise.swift
//  MVC-N
//
//  Created by Abdurazzoqov Islombek on 14/09/23.
//

import UIKit

class NetworkServise {
    
    private init () {}
    static let shared = NetworkServise()

    public func getDataWith(url: URL, completion: @escaping (Data) -> ()) {
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                completion(data)
            }
        }.resume()
    }
    
}
