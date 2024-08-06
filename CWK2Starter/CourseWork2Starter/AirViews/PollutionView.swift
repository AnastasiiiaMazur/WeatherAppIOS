 //
//  PollutionView.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    @StateObject var airQualityModel = AirQualityViewModel()
    @State  var userLocation: String = ""
    
    var body: some View {
        
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .opacity(0.8)
            
                VStack {
                    Text(userLocation)
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                    Text("\((Int)(modelData.forecast!.current.temp))ºC")
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    HStack{
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                            .padding()
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                    
                    HStack{
                        Text("H: \((Int)(modelData.forecast!.current.temp))ºC")
                            .foregroundColor(.black)
                            .padding()
                            .shadow(color: .black, radius: 0.5)
                        Text("Low: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                            .foregroundColor(.black)
                            .padding()
                            .shadow(color: .black, radius: 0.5)
                    }
                    
                    Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                        .foregroundColor(.black)
                        .padding()
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Air Quality Data:")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack{
                        VStack{
                            Image("so2")
                                .resizable()
                                .frame(width: 65, height: 65)
                            Text(String(format: "%.2f", (airQualityModel.airQuality?.list[0].components.so2) ?? 0.0))
                        }
                        
                        VStack{
                            Image("no")
                                .resizable()
                                .frame(width: 65, height: 65)
                            Text(String(format: "%.2f", (airQualityModel.airQuality?.list[0].components.no) ?? 0.0))
                        }.padding(.horizontal)
                        
                        VStack{
                            Image("voc")
                                .resizable()
                                .frame(width: 65, height: 65)
                            Text("203.61")
                        }.padding(.trailing)
                        
                        VStack{
                            Image("pm")
                                .resizable()
                                .frame(width: 65, height: 65)
                            Text(String(format: "%.2f", (airQualityModel.airQuality?.list[0].components.pm10) ?? 0.0))
                        }
                            
                    }
                    
                    
                }.onAppear {
                    Task.init {
                        let airQualityData = try await airQualityModel.getData(lat: modelData.forecast!.lat, lon:modelData.forecast!.lon)
                            DispatchQueue.main.async {
                                airQualityModel.airQuality = airQualityData
                            }
                        self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    }
                }
            }
        }
    }

    
//struct Pollution_Previews: PreviewProvider {
//    static var previews: some View {
//        PollutionView().environmentObject(ModelData())
//    }
//}
