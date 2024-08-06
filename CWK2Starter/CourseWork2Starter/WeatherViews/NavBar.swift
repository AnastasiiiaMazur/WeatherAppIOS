//
//  NavBar.swift
//  Coursework2
//
//  Created by AnastasiiaMazur
//

import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
           Home()
                .tabItem{
                    Label("City", systemImage: "magnifyingglass")
                    //Text("City")
                }
            CurrentWeatherView()
                .tabItem {
                    Label("WeatherNow", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    Label("Hourly Summary", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    Label("Pollution", systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

