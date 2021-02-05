//
//  DisplayMetalView.swift
//  Yeahhhhh
//
//  Created by クワシマ・ユウキ on 2021/02/04.
//
import MetalKit
import SwiftUI

struct DisplayMetalView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<DisplayMetalView>) -> MTKView {
        
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
//        mtkView.preferredFramesPerSecond = 10
        mtkView.enableSetNeedsDisplay = false
        mtkView.device = GPUCore.shared.device
 
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<DisplayMetalView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            
        }
        
        var count: Float = 0.0
        
        func draw(in view: MTKView) {
            guard let drawable = view.currentDrawable, let renderPassDescriptor = view.currentRenderPassDescriptor else {
                return
            }
            
            let commandBuffer = GPUCore.shared.commandQueue.makeCommandBuffer()
            var renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
            
            
            
            
//            for i in 0..<100 {
//                GPURender.Run_DrawTriangle(&renderCommandEncoder!, Float.random(in: 0...1), Float.random(in: 0...1), 0.015, (1, 0, 0.5))
//                GPURender.Run_DrawTriangle(&renderCommandEncoder!, Float.random(in: -1...1), Float.random(in: -1...1), Float.random(in: -1...1), 0.15, (1, 0, 0.5))

//            }
            
//            GPURender.Run_DrawTetrahedron(&renderCommandEncoder!, Float.random(in: -1...1), Float.random(in: -1...1), Float.random(in: -1...1), 0.015, (1, 0, 0.5))
//            GPURender.Run_DrawTetrahedron(&renderCommandEncoder!, 0, 0, Float.random(in: -0.1...0), 0.015, (1, 0, 0.5))
            GPURender.Run_DrawTetrahedron(&renderCommandEncoder!, 0, 0, 0, 0.5, (1, 0, 0.5))
//            count -= 0.0001
            
//            print(count)
            
//            print("gdgdgr")
            
            
            renderCommandEncoder?.endEncoding()
                    
            commandBuffer?.present(drawable)
            
//            commandBuffer?.addCompletedHandler({buf in
//                let data = 
//            })
            
            commandBuffer?.commit()
            
            
        }
        
        init(_ parent: DisplayMetalView) {
            super.init()
        }
    }
    
}
