//
//  ARUIView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//
import SwiftUI

struct ARUIView: View{
    @EnvironmentObject var data: DataModel
    var body: some View{
        List{
            Toggle(isOn: $data.enableAR){
                Text("show ar")
            }
            Stepper("X:\(Int(data.xTranslation))",value: $data.xTranslation,in:-100...100)
            Stepper("Y:\(Int(data.yTranslation))",value: $data.yTranslation,in:-100...100)
            Stepper("Z:\(Int(data.zTranslation))",value: $data.zTranslation,in:-100...100)
        }.frame(width: CGFloat(200))
    }
}
