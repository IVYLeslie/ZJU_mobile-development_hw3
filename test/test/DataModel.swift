//
//  DataModel.swift
//  test
//
//  Created by 朱雨珂 on 2022/6/15.
//

import ARKit
import Combine
import RealityKit
import CoreLocation
import SwiftUI


final class DataModel: ObservableObject{
    static var shared = DataModel()
    @Published var arView: ARView!
    @Published var enableAR = false
    @Published var xTranslation:Float=0{
        didSet{translateBox()}
    }
    @Published var yTranslation:Float=0{
        didSet{translateBox()}
    }
    @Published var zTranslation:Float=0{
        didSet{translateBox()}
    }
    init (){
//        arView = ARView(frame: .zero)
//
//        let a=try!A.loadAscene()
//        arView.scene.anchors.append(a)
        let location = CLLocationCoordinate2D(latitude: -18.9137, longitude: 47.5361)
        let geoAnchor = ARGeoAnchor(name: "hi", coordinate: location, altitude: 1250)
        arView.session.add(anchor: geoAnchor)
        let realityKitAnchor = AnchorEntity(anchor: geoAnchor)
        arView.scene.anchors.append(realityKitAnchor)
        
        
    }
    
    func translateBox(){
        if let steelBox = (arView.scene.anchors[0] as?A.Ascene)?.a{
            let xTranslationM=xTranslation/10
            let yTranslationM=yTranslation/10
            let zTranslationM=zTranslation/10
            let translation=SIMD3<Float>(xTranslationM,yTranslationM,zTranslationM)
            steelBox.transform.translation=translation
        }
    }
}
