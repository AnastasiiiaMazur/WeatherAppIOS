//
//  HourCondition.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct HourCondition: View {
    @EnvironmentObject var modelData: ModelData
    
    var current : Current
    var hour : Int
  
    var body: some View {
        HStack {
            HStack {
                //Text("hour value \(hour)")
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)((modelData.forecast?.hourly[hour].dt)!))))
                    .formatted(.dateTime.hour().weekday()))
                    .foregroundColor(.black)
                    .padding(.trailing)
                    .font(.title3)
                
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.hourly[hour].weather[0].icon)@2x.png")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                Text("\((Int)((modelData.forecast?.hourly[hour].temp)!))ºC")
                    .foregroundColor(.black)
                    .padding()
                Text(modelData.forecast!.hourly[hour].weather[0].weatherDescription.rawValue.capitalized)
                    .padding()
                    .font(.body)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
            }
            Spacer()

        }.padding()
    }
}

//struct HourCondition_Previews: PreviewProvider {
//    static var hourly = ModelData().forecast!.hourly
//    
//    static var previews: some View {
//        HourCondition(current: hourly[0], hour: 0)
//    }
//}
