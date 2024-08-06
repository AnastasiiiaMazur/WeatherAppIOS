//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by AnastasiiaMazur
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    
    var body: some View {
        Spacer()
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            // Call the loadData function to load weather data for the new location
                            Task {
                                do {
                                    let newForecast = try await self.modelData.loadData(lat: lat, lon: lon)
                                    // Update the userLocation and isSearchOpen state variables
                                    self.modelData.userLocation = location
                                    self.userLocation = location
                                    self.isSearchOpen.toggle()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
                })
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
            }
        }
        Spacer()
    }
}
