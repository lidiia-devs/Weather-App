//
//  ContentView.swift
//  Weather App
//
//  Created by Lidiia Diachkovskaia on 2/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var weatherObject: WeatherObject?
    
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
            VStack {
                // Search Bar
                HStack {
                    TextField("Search Location", text: $searchText, onEditingChanged: { isEditing in
                        if isEditing {
                          
                        }
                    })
                    .textFieldStyle(.automatic)
                    .padding(.leading)
                    .font(Font.custom("Poppins-Regular", size: 16))
                  
                    
                    
                    Button(action: {
                        fetchWeather(for: searchText)
                    }) {
                        Label("Search", systemImage: "magnifyingglass")
                            .labelStyle(.iconOnly)
                            .padding()
                            .foregroundColor(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(.trailing,5.0)
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal, 20.0)
                .padding(.top, 10)
            }
        
        if isLoading {
            ProgressView("Fetching weather ...")
        } else if let weather = weatherObject {
            WeatherView(weather: weather)
            //fill in wirh weather app object
            Text(weather.tempFahrenheit?.asDisplayString() ?? "N/A")
            Text(weather.tempCelcius?.asDisplayString() ?? "N/A")
        } else if let error = errorMessage {
            Text(error)
                .foregroundColor(.red)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            VStack {
                Text("No city selected")
                    .font(Font.custom("Poppins-SemiBold", size: 30))
                    .padding(.bottom, 1.0)
                Text("Please search for a city")
                    .font(Font.custom("Poppins-Regular", size: 30))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        
        
       
        
        
        
        
        }
    
    private func fetchWeather (for city: String) {
        guard !city.isEmpty else {
            errorMessage = "Enter city name."
            return
        }
    
        isLoading = true
        weatherObject = nil
        errorMessage = nil
        
        Task {
            do {
                let fetchWeatherObject = try await NetworkController.fetchWeatherData(city)
                
                await MainActor.run {
                    
                    weatherObject = fetchWeatherObject
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Error: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
        
    }

}
