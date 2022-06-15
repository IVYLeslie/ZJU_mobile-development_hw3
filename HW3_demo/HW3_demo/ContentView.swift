//
//  ContentView.swift
//  HW3_demo
//
//  Created by 朱雨珂 on 2022/5/21.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
