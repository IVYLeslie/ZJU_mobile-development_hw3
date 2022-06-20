//
//  ARUIView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//
import SwiftUI
import CoreLocation
struct ARUIView: View{
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    var body: some View{
        
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationViewModel)
        case .restricted:
            ErrorView(errorText: "Location use is restricted.")
        case .denied:
            ErrorView(errorText: "The app does not have location permissions. Please enable them in settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            ZStack{
                ARDisplayView().environmentObject(locationViewModel)
                HStack{
                    List{
                        Toggle(isOn: $data.enableAR){
                            Text("show ar")
                        }
                        Stepper("X:\(Int(data.xTranslation))",value: $data.xTranslation,in:-100...100)
                        Stepper("Y:\(Int(data.yTranslation))",value: $data.yTranslation,in:-100...100)
                        Stepper("Z:\(Int(data.zTranslation))",value: $data.zTranslation,in:-100...100)
                    }.frame(width: CGFloat(300))
                    Spacer()
                    TrackingView()
                        .environmentObject(locationViewModel)
                }
                
                
            }
                
        default:
            Text("Unexpected status")
        }
    }
}
struct RequestLocationView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Button(action: {
                locationViewModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("We need your permission to track you.")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
}

struct ErrorView: View {
    var errorText: String
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct TrackingView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
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


struct ARUIView_Previews : PreviewProvider {
    static var previews: some View {
        ARUIView()
    }
}
