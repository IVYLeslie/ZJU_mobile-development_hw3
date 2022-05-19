import RealityKit
import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable{
    @EnvironmentObject var arViewModel :ARViewModel
    @Binding var addCube: Bool
    @Binding var intensity: CGFloat
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.arView.enableTapGesture()
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
//        if addCube{
//            print("add Cube")
//            let boxMesh = MeshResource.generateBox(size: 1)
//            let material = SimpleMaterial(color: .blue, isMetallic: false)
//            let modelEntity = ModelEntity(mesh: boxMesh, materials: [material])
//            let anchorEntity = AnchorEntity()
//
//            anchorEntity.addChild(modelEntity)
//            arViewModel.arView.scene.addAnchor(anchorEntity)
//            DispatchQueue.main.async {
//                addCube = false
//            }
//        }
    }
    
    
    
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
    
//    class Coordinator: NSObject, ARSessionDelegate{
//        var parent: ARViewContainer
//
//        init(_ arViewContainer: ARViewContainer){
//            parent = arViewContainer
//            super.init()
//        }
//
//        func session(_ session: ARSession, didUpdate frame: ARFrame) {
//            if let intensity = frame.lightEstimate?.ambientIntensity{
//                parent.intensity = intensity
//            }
//
//        }
//
//
//
//    }
}

extension ARView {
    func enableTapGesture() {
        let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer: )))
        self.addGestureRecognizer(tapGestureRecongnizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        let tapLocation = recognizer.location(in: self)
        
        guard let rayResult = self.ray(through: tapLocation) else {return}
    
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)  // Raycast on virtual scene
        if let firstResult = results.first {
            print("[Debug] stack")

            var position = firstResult.position
            position.y += 0.3 / 2
            placeCube(at: position)
        } else {
            let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
            
            if let firstResult = results.first {
                let position = simd_make_float3(firstResult.worldTransform.columns.3)
                placeCube(at:position)
            }
        }
        
    }
    
    func placeCube(at position: SIMD3<Float>) {
        //let mesh = MeshResource.generateBox(size: 0.3)
        //let material = SimpleMaterial(color:.white, roughness: 0.3, isMetallic: true)
        //let modelEntity = ModelEntity(mesh:mesh, materials:[material])
        let modelEntity = try! ModelEntity.loadModel(named: "A")
        modelEntity.generateCollisionShapes(recursive: true)
        
        
        let anchorEntity = AnchorEntity(world: position)
        anchorEntity.addChild(modelEntity)
        
        self.scene.addAnchor(anchorEntity)
    }
    
    
    
}
