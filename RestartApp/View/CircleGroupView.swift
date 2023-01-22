//
//  CircleGroupView.swift
//  RestartApp
//
//  Created by Yusril on 17/01/23.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State var isAnimate: Bool = false
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }//zstack
        .blur(radius: isAnimate ? 1 : 10)
        .opacity(isAnimate ? 1 : 0)
        .scaleEffect(isAnimate ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimate)
        .onAppear(perform: {
            isAnimate = true
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
        }
    }
}
