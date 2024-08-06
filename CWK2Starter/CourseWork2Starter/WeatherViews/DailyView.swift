//
//  DailyView.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct DailyView: View {
    @EnvironmentObject var modelData: ModelData
    
    var day : Daily
    var days : Int
  
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.daily[days].weather[0].icon)@2x.png")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                
                VStack{
                    Text(modelData.forecast!.daily[days].weather[0].weatherDescription.rawValue.capitalized)
                        //.padding()
                        .font(.body)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)((modelData.forecast?.daily[days].dt)!))))
                        .formatted(.dateTime.weekday().day()))
                        .foregroundColor(.black)
                        //.padding(.trailing)
                        .font(.body)
                }
                Text("\((Int)((modelData.forecast?.daily[days].temp.min)!))ºC / \((Int)((modelData.forecast?.daily[days].temp.max)!))ºC")
                    .foregroundColor(.black)
                    .padding()
    
            }
            Spacer()

        }.padding()
    }
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0], days: 0)
    }
}
