//
//  AirQualityData.swift
//  CourseWork2Starter
//
//  Created by Anastasiia Mazur
//

import Foundation


struct AirQualityData: Decodable {
    let list: [AirQuality]
}

struct AirQuality: Decodable {
    let components: AirQualityComponents
}

struct AirQualityComponents: Decodable {
    let co: Double?
    let no: Double?
    let no2: Double?
    let o3: Double?
    let so2: Double?
    let pm2_5: Double?
    let pm10: Double?
    let nh3: Double?
}

class AirQualityViewModel: ObservableObject {
    @Published var airQuality: AirQualityData?

    func getData(lat: Double, lon: Double) async throws -> AirQualityData {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=API_KEY")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let airQualityData = try JSONDecoder().decode(AirQualityData.self, from: data)
            DispatchQueue.main.async {
                self.airQuality = airQualityData
            }
            return airQualityData
        } catch {
            throw error
        }
    }
}



