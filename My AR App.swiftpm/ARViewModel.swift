import RealityKit
import SwiftUI
import ARKit

class ARViewModel: ObservableObject{
    var arView: ARView
    init(){
        arView = ARView()
        arView.setupForARWorldConfiguration()
#if DEBUG
//        arView.debugOptions = [.showAnchorOrigins, .showAnchorGeometry]
#endif
    }
}

extension ARView{
    func setupForARWorldConfiguration(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.isAutoFocusEnabled = false
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .automatic
        configuration.isLightEstimationEnabled = true
        self.session.run(configuration)
    }
}
