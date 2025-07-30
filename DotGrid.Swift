//
//  SwiftUIView.swift
//  SwiftJun24
//
//  Created by Minsang Choi on 6/26/25.
//
import SwiftUI

struct DotGrid: View {
    var rows: Int = 30
    var columns: Int = 30
    var spacing: CGFloat = 10
    var dotDiameter: CGFloat = 4
    var color: Color = .primary
    
    var body: some View {
        Canvas { context, size in
            let offsetX = (size.width  - CGFloat(columns - 1) * spacing) / 2
            let offsetY = (size.height - CGFloat(rows    - 1) * spacing) / 2
            
            for row in 0..<rows {
                for col in 0..<columns {
                    let x = offsetX + CGFloat(col) * spacing
                    let y = offsetY + CGFloat(row) * spacing
                    let rect = CGRect(
                        x: x - dotDiameter / 2,
                        y: y - dotDiameter / 2,
                        width: dotDiameter,
                        height: dotDiameter
                    )
                    context.fill(Path(ellipseIn: rect), with: .color(color))
                }
            }
        }
        .drawingGroup(opaque: false, colorMode: .linear)
    }
}



struct Jun26 : View {
    @State private var dragp : CGPoint = .zero
    @State private var strength : CGFloat = 0.0
    @State private var noise : CGFloat = 0.033
    @State private var time : CGFloat = 0.1

    var body: some View {
        
        ZStack{
            Color.black
                .ignoresSafeArea()
            DotGrid(color:.white)
                .frame(width: 400, height: 400)
                .layerEffect(ShaderLibrary.dotwave(.boundingRect, .float2(dragp),.float(time),.float(noise),.float(strength)), maxSampleOffset: CGSize(width: 400, height: 400))
                .offset(y:-50)
                .padding()
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            strength = 3.6
                            dragp = value.location
                            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 0.55)
                        }
                        .onEnded { value in
                            withAnimation(.spring(.bouncy)){
                                strength = 0.0
                            }
                        }
                )

            VStack{
                Spacer()
                VStack(spacing:8){
                    HStack{
                        Text("0626 - Metal Shader")
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                            .bold()
                            .fontDesign(.monospaced)
                        Spacer()
                    }
                    HStack{
                        Text("Dot of grid reacting to touch. Tap and drag to change.")
                            .foregroundStyle(.white)
                            .font(.system(size: 12))
                        Spacer()
                    }

                    
                }
                .frame(width: .infinity, height:120)
                .cornerRadius(20)
                .padding(32)
                
            }
            
        }
        
//        VStack{
//            Text("\(noise), \(strength)")
//            Slider(value: $noise, in:0...0.1)
//            Slider(value: $strength, in:0...40)
//        }
//        .padding()
    }
}

#Preview {
    Jun26()
}
