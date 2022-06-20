//
//  ContentView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//

import SwiftUI
import RealityKit
import CoreLocation

struct ContentView : View {
    @EnvironmentObject var data:DataModel
    @StateObject var locationViewModel = LocationViewModel()
    var body: some View {
        ZStack{
            //ARDisplayView()
            ARUIView().environmentObject(locationViewModel)
            
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
