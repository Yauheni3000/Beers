//
//  Networking.swift
//  Beers
//
//  Created by Yauheni Yursha on 17/11/2023.
//

import Foundation

struct Networking {
    static let shared = Networking()
    private init () {}
    
    func fetchData(from url: String?, with completion: @escaping([Beer]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let beer = try JSONDecoder().decode([Beer].self, from: data)
                DispatchQueue.main.async {
                    completion(beer)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    func fetchImageString(from url: String?, with completion: @escaping(Data) -> Void) {
        guard let stringURL = url else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }

    func fetchImage(from url: URL, with complition: @escaping(Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                complition(.success(data))
            }
        }.resume()
    }
    
    
}
