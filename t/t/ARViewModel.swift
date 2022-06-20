//
//  ARViewModel.swift
//  t
//
//  Created by 朱雨珂 on 2022/6/16.
//

import SwiftUI
import ARKit
import RealityKit

class ARViewModel: ObservableObject {
    var arView = ARView(frame: .zero)
    init() {
//        arView.setupForARWorldConfiguration()
    }
    
}

extension ARView {
    func setupForARWorldConfiguration(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.isAutoFocusEnabled = true
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        configuration.isLightEstimationEnabled = true
        self.session.run(configuration)
    }
}
