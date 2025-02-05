//
//  WeatherView.swift
//  Weather App
//
//  Created by Lidiia Diachkovskaia on 2/4/25.
//
import SwiftUI

struct WeatherView: View {
    
    let weather : WeatherObject
    
    var body: some View {
        AsyncImage(url: weather.iconURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                VStack {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 140, maxHeight: 140)
                        .padding(.bottom, 10.0)
                    Text(weather.cityName ?? "add error handling for currupted data")
                        .font(Font.custom("Poppins-SemiBold", size: 30))
                    HStack {
                        Text((weather.tempFahrenheit?.asDisplayString() ?? ""))
                            .font(Font.custom("Poppins-SemiBold", size: 70))
                        Text("°")
                            .font(Font.custom("Poppins-Regular", size: 20))
                            .offset(y: -20)
                    }
                    HStack {
                        VStack{
                            Text("Humidity")
                                .font(Font.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color(hex: "#C4C4C4"))
                                .padding(.top, 20)

                            Text((weather.humidity?.asDisplayString() ?? "") + "%")
                                .font(Font.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(Color(hex: "#9A9A9A"))
                                .padding(.bottom, 20)

                        }
                        .padding(.horizontal, 20)
                        VStack{
                            Text("UV")
                                .font(Font.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color(hex: "#C4C4C4"))
                                .padding(.top, 20)

                            Text(weather.uv?.asDisplayString() ?? "")
                                .font(Font.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(Color(hex: "#9A9A9A"))
                                .padding(.bottom, 20)

                        }
                        .padding(.horizontal, 20)
                        VStack{
                            Text("Feels Like")
                                .font(Font.custom("Poppins-Regular", size: 10))
                                .foregroundColor(Color(hex: "#C4C4C4"))
                                .padding(.top, 20)

                            Text((weather.feelsLikeF?.asDisplayString() ?? "") + "°")
                                .font(Font.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(Color(hex: "#9A9A9A"))
                                .padding(.bottom, 20)

                        }
                        .padding(.horizontal, 20)

                    }
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(15)
                    .padding(20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)


            case .failure:
                Image(systemName: "cloud.fill") // Fallback image in case of failure
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .foregroundColor(.gray) // Optional: Add a tint to the fallback image
            @unknown default:
                EmptyView()
            }
        }
    }
    
}
















