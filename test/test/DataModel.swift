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
        arView = ARView(frame: .zero)
        if (enableAR){
            let ascene=try!AA.loadAscene()
            arView.scene.anchors.append(ascene)
        }
    }
    
    func translateBox(){
        if let steelBox = (arView.scene.anchors[0] as?AA.Ascene)?.a{
            let xTranslationM=xTranslation/10
            let yTranslationM=yTranslation/10
            let zTranslationM=zTranslation/10
            let translation=SIMD3<Float>(xTranslationM,yTranslationM,zTranslationM)
            steelBox.transform.translation=translation
        }
    }
}
