//
//  ContentView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @EnvironmentObject var data:DataModel
    var body: some View {
        HStack{
            ARUIView()
            if data.enableAR{
                ARDisplayView()
            }
            else{
                Spacer()
            }
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
