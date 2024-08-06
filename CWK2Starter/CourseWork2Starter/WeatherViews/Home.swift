//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by AnastasiiaMazur
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .opacity(0.8)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                            .padding(.top)
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding()
                    
                    Spacer()
                }
                //Spacer()
                
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                //Spacer()
                
                VStack{
                    Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                        .padding()
                        .font(.title3)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                        .padding()
                        .font(.title3)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPa")
                        .padding()
                        .font(.title3)
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
                }
                
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                }
                
            }
        }
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
