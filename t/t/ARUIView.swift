//
//  ARUIView.swift
//  t
//
//  Created by 朱雨珂 on 2022/6/16.
//
import SwiftUI
struct ARUIView: View{
    @ObservedObject var locationViewModel: LocationViewModel
    private var lati:Double?{
        locationViewModel.lastSeenLocation?.coordinate.latitude
    }
    
    private var longti:Double?{
        locationViewModel.lastSeenLocation?.coordinate.longitude
    }
    private var alti:Double?{
        locationViewModel.lastSeenLocation?.altitude
    }
    private var ladis:Double?{
        fabs((lati ?? -1000)-30.268)
    }
    private var longdis:Double?{
        fabs((longti ?? -1000)-120.117)
    }
    private var altidis:Double?{
        fabs((alti ?? -100)-24)
    }
    
    var body: some View {
        //showAR=(altidis ?? 1000>0.001 || longdis ?? 1000>0.001 || altidis ?? -100>5)
        
        VStack {
            HStack{
                Spacer()
                VStack {
                    HStack{
                        Text("Latitude:")
                        Text(String(lati ?? 0))
                    }
                    HStack{
                        Text("Longitude:")
                        Text(String(longti ?? 0))
                    }
                    HStack{
                        Text("Altitude:")
                        Text(String(alti ?? 0))
                    }
                    HStack{
                        Text("Speed:")
                        Text(String(locationViewModel.lastSeenLocation?.speed ?? 0))
                    }
                    HStack{
                        Text("Country:")
                        Text(locationViewModel.currentPlacemark?.country ?? "")
                    }
                    HStack{
                        Text("City:")
                        Text(locationViewModel.currentPlacemark?.administrativeArea ?? "")
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).fill(.white))
            }
            Spacer()
        }
    }
}

