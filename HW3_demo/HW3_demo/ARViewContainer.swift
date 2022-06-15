//
//  ARViewContainer.swift
//  HW3_demo
//
//  Created by 朱雨珂 on 2022/5/22.
//

import RealityKit
import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let chessboard = try! Chess.self.load_Chess()
        chessboard.generateCollisionShapes(recursive: true)
        // Add the box anchor to the scene
        arView.scene.anchors.append(chessboard)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
