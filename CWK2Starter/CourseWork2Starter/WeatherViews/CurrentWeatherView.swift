//
//  Conditions.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"

    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .opacity(0.8)
            
            VStack {
                Text(locationString)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                VStack{
                    VStack {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        
                        HStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        }
                        
                        HStack{
                            Text("H: \((Int)(modelData.forecast!.current.temp))ºC")
                                .foregroundColor(.black)
                                .padding()
                            Text("Low: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                                .foregroundColor(.black)
                                .padding()
                        }
                        
                        Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)
                            .padding()
                        
                        HStack{
                            Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                                .foregroundColor(.black)
                                .padding()
                                .font(.title3)
                            Text("Direction: \((convertDegToCardinal(deg: modelData.forecast!.current.windDeg)))")
                                .foregroundColor(.black)
                                .padding()
                                .font(.title3)
                        }
                        
                        HStack{
                            Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                                .foregroundColor(.black)
                                .padding()
                                .font(.title3)
                            Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPg")
                                .foregroundColor(.black)
                                .padding()
                                .font(.title3)
                        }
                        
                        HStack{
                            Image(systemName: "sunrise.fill")
                                .renderingMode(.original)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunrise ?? 0))))
                                .formatted(.dateTime.hour()))
                            .foregroundColor(.black)
                            .padding(.trailing)
                            .font(.title3)
                            
                            Image(systemName: "sunset.fill")
                                .renderingMode(.original)
                            Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.sunset ?? 0))))
                                .formatted(.dateTime.hour()))
                            .foregroundColor(.black)
                            .font(.title3)
                            
                        }
                    }.padding(.trailing)
                    
                }
                
            }.foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
                .onAppear {
                    Task.init {
                        self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    }
                }.ignoresSafeArea(edges: [.top, .trailing, .leading])
        }
    }
}
    struct Conditions_Previews: PreviewProvider {
        static var previews: some View {
            CurrentWeatherView()
                .environmentObject(ModelData())
        }
    }

