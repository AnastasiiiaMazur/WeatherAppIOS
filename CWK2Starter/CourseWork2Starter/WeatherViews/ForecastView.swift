//
//  Forecast.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        ZStack{
            Image("background2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .opacity(0.8)
            
            
            VStack{
                Text(locationString)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                List{
                    ForEach(modelData.forecast!.daily.indices) { day in
                        DailyView(day: modelData.forecast!.daily[day], days: day)
                    }
                }
            }
            .padding(.horizontal)
            .frame(width: 440.0)
            .opacity(0.8)
            
            .onAppear {
                Task.init {
                    self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                }
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
