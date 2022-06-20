//
//  ARDisplayView.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//
import SwiftUI
import RealityKit
struct ARDisplayView:View{
    var body:some View{
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        return DataModel.shared.arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

