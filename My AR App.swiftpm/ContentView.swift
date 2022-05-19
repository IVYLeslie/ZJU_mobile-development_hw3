import SwiftUI

struct ContentView: View {
    @StateObject var arViewModel = ARViewModel()
    @State var addCube = false
    @State var intensity = CGFloat(0.0)
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer(addCube: $addCube, intensity: $intensity).gesture(TapGesture().onEnded(){ 
                
            })
            
            Button(action: {
                addCube = true
            }, label: {
                Text("放置一个立方体")
            })
                .buttonStyle(.bordered)
                .padding()
            
            Text("Intensity: \(intensity)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
        }
        .environmentObject(arViewModel)
    }
}
