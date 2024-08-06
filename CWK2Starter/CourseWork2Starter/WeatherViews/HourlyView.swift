//
//  Hourly.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var userLocation: String = "No location"
    //@State var hour: Int
    
    var body: some View {
        
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .opacity(0.8)
            
            VStack{
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                VStack{
                    List {
                        ForEach(modelData.forecast!.hourly.indices) { hour in
                            HourCondition(current: modelData.forecast!.hourly[hour], hour: hour)

                        }
                    }
                    .padding(.horizontal)
                    .frame(width: 440.0)
                    .opacity(0.7)
                }
                
            }
            
            
        }.onAppear {
            Task.init {
                self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
