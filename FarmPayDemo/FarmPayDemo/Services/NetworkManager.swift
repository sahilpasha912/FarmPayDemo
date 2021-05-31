//
//  CallApi.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 23/05/21.
//
enum Result {
   case success(CardDetail)
   case failure(Error)
}

import UIKit
import Foundation

struct NetworkManager {
    
    static func getResponseFromApi(url: String, callback:@escaping (_ response: (Result)) -> (Void)) {
        
        let session = URLSession.shared
        let url = URL(string: url)!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                callback(.failure(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                callback(.failure(error!))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                callback(.failure(error!))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(CardDetail.self, from: data!)
                print(decodedData)
                callback(.success(decodedData))
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}
