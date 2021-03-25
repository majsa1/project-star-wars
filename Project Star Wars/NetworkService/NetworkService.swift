//
//  NetworkService.swift
//  Project Star Wars
//
//  Created by Marjo Salo on 16/11/2020.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let URL_PEOPLE = "https://swapi.dev/api/people/"
    let dispatchGroup = DispatchGroup()
    let session = URLSession(configuration: .default)
    
    func getPeople(onSuccess: @escaping (Person) -> Void, onError: @escaping (String) -> Void) {
        
        for number in 1...83 {
            let url = URL(string: "\(URL_PEOPLE)\(number)")!
            dispatchGroup.enter()
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        onError("Invalid data or response")
                        return
                    }
                    
                    do {
                        
                        if response.statusCode == 200 {
                            let person = try JSONDecoder().decode(Person.self, from: data)
                            onSuccess(person)
                
                        }
                    } catch {
                        onError(error.localizedDescription)
                    }
                    
                    self.dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
            }
          task.resume()
        }
    }

    func getPlanet(url: String, onSuccess: @escaping (Planet) -> Void, onError: @escaping (String) -> Void) {
        let planetUrl = URL(string: url)!
        
        let task = session.dataTask(with: planetUrl) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let planet = try JSONDecoder().decode(Planet.self, from: data)
                        onSuccess(planet)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
