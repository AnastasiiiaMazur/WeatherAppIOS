//
//  APIConnect.swift
//  CourseWork2Starter
//
//  Created by Anastasiia Mazur

import Foundation


func getWeatherData(url: String, completion: @escaping ([ModelData])->()) {
    let session = URLSession(configuration: .default)
    session.dataTask(with: URL(string: url)!) {(data, _, err) in
        
        if err != nil {
            print(err!.localizedDescription)
            return
        }
        DispatchQueue.main.async {
            do {
                let users = try JSONDecoder().decode([ModelData].self, from: data!)
                print(String(data: data!, encoding: .utf8) ?? "Error")
                completion(users)
                print("users loaded \(users)")
            } catch {
                print(error)
            }
        }
    }.resume()
}
