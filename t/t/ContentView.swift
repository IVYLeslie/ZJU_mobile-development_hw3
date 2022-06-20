
//
//  ContentView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//

import SwiftUI
import RealityKit
import CoreLocation
import ARKit


struct ContentView : View {
    //@EnvironmentObject var data:DataModel
    @StateObject var locationViewModel = LocationViewModel()
    var body: some View {
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
                ARViewContainer(locationViewModel: locationViewModel).edgesIgnoringSafeArea(.all)
                ARUIView(locationViewModel: locationViewModel)
                //TrackingView().environmentObject(locationViewModel)
                
            }
        default:
            Text("Unexpected status")
        }
        
    }
}


struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var arViewModel = ARViewModel()

    @ObservedObject var locationViewModel: LocationViewModel
    //@State var alreadyShown = false
    var lati:Double?{
        locationViewModel.lastSeenLocation?.coordinate.latitude
    }

    var longti:Double?{
        locationViewModel.lastSeenLocation?.coordinate.longitude
    }
    var alti:Double?{
        locationViewModel.lastSeenLocation?.altitude
    }
    var ladis:Double?{
        fabs((lati ?? -1000)-30.268)
    }
    var longdis:Double?{
        fabs((longti ?? -1000)-120.117)
    }
    var altidis:Double?{
        fabs((alti ?? -100)-24)
    }
        
    func makeUIView(context: Context) -> ARView {
        let show = ((ladis ?? 1000)<0.001) && ((longdis ?? 1000)<0.001) && ((altidis ?? 1000)<5)
        // Load the "Box" scene from the "Experience" Reality File
        print("lati=",lati ?? 1000)
        print("longti=",longti ?? 1000)
        print("alti=",alti ?? 1000)
        print("latidis=",ladis ?? 1000)
        print("longtidis=",longdis ?? 1000)
        print("altidis=",altidis ?? 1000)
        print(show)
        if(show){
            //let a = try! A.loadAscene()
            //let aa = try! AA.loadAscene()
            print("here aa")
            //dump(aa)
            print(show)
            // Add the box anchor to the scene
            //arViewModel.arView.scene.anchors.append(aa)
        }
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        //if !alreadyShown {
            let show = ((ladis ?? 1000)<0.001) && ((longdis ?? 1000)<0.001) && ((altidis ?? 1000)<5)
        
            print("session lati=",lati ?? 1000)
            print("longti=",longti ?? 1000)
            print("alti=",alti ?? 1000)
            print("latidis=",ladis ?? 1000)
            print("longtidis=",longdis ?? 1000)
            print("altidis=",altidis ?? 1000)
            print(show)
            if(show){
                //let a = try! A.loadAscene()
                //let aa = try! AA.loadAscene()
                //dump(a)
                print(show)
                // Add the box anchor to the scene
//                DispatchQueue.main.async {
//                    arViewModel.arView.scene.anchors.append(a)
//                    //alreadyShown = true
//                }
                //arViewModel.arView.scene.anchors.append(aa)
                print("finished")
            }
        //}
    }
//    func makeCoordinator() -> Coordinator {
//            Coordinator(self)
//    }
//    
//    final class Coordinator: NSObject, ARSessionDelegate{
//        var parent: ARViewContainer
//        var frameCounter = 0
//        init(_ arViewContainer: ARViewContainer) {
//            parent = arViewContainer
//            super.init()
//            parent.arViewModel.arView.session.delegate = self
//            print("here")
//        }
//
//
//        func session(_ session: ARSession, didUpdate frame: ARFrame) {
//            if frameCounter % 5 == 0 {
//                let show = ((parent.ladis ?? 1000)<0.001) && ((parent.longdis ?? 1000)<0.001) && ((parent.altidis ?? 1000)<5)
//                // Load the "Box" scene from the "Experience" Reality File
//                //let boxAnchor = try! Experience.loadBox()
//                print("session lati=",parent.lati ?? 1000)
//                print("longti=",parent.longti ?? 1000)
//                print("alti=",parent.alti ?? 1000)
//                print("latidis=",parent.ladis ?? 1000)
//                print("longtidis=",parent.longdis ?? 1000)
//                print("altidis=",parent.altidis ?? 1000)
//                print(show)
//                if(show){
//                    //let a = try! A.loadAscene()
//                    let aa = try! AA.loadAscene()
//                    print("here")
//                    dump(aa)
//                    print(show)
//                    // Add the box anchor to the scene
//                    parent.arViewModel.arView.scene.anchors.append(aa)
//                }
//            }
//            frameCounter += 1
//        }
//    }
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
    //@Binding var showAR:Bool
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

struct PairView: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(leftText)
            
            Text(rightText)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
