//
//  LocationHelper.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import Foundation

import CoreLocation

func getLocFromLatLong(lat: Double, lon: Double) async -> String
{
    var locationString: String
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let ceo: CLGeocoder = CLGeocoder()
    
    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    do {
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        if placemarks.count > 0 {
            
            
            if (!placemarks[0].name!.isEmpty) {
                
                locationString = placemarks[0].name!
                
            } else {
                locationString = (placemarks[0].locality ?? "No City")
            }
            
            return locationString
        }
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
       
        return locationString
    }
    
    return "Error getting Location"
}

func getLanLongFromLoc(for location: String, completion: @escaping (Result<(latitude: Double, longitude: Double), Error>) -> Void) {
    let geocoder = CLGeocoder()

    geocoder.geocodeAddressString(location) { placemarks, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let placemark = placemarks?.first,
              let location = placemark.location else {
            completion(.failure(NSError(domain: "com.example", code: 0, userInfo: [NSLocalizedDescriptionKey: "Location not found"])))
            return
        }

        let coordinates = (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        completion(.success(coordinates))
    }
}



