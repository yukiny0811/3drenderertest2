//
//  GPUCore.swift
//  Yeahhhhh
//
//  Created by クワシマ・ユウキ on 2021/02/04.
//

import Metal
import simd

class GPUCore {
    
    public static let shared = GPUCore()
    
    public var device: MTLDevice!
    public var library: MTLLibrary!
    public var commandQueue: MTLCommandQueue!
    
    private static var computePipelineStates: [String: MTLComputePipelineState] = [:]
    private var vertexFunctions: [String: MTLFunction] = [:]
    private var fragmentFunctions: [String: MTLFunction] = [:]
    
    private init() {
        self.device = MTLCreateSystemDefaultDevice()!
        let frameworkBundle = Bundle(for: GPUCore.self)
        library = try! self.device.makeDefaultLibrary(bundle: frameworkBundle)
        commandQueue = self.device.makeCommandQueue()!
        
        vertexFunctions["test_vertex"] = self.library.makeFunction(name: "test_vertex")
        fragmentFunctions["test_fragment"] = self.library.makeFunction(name: "test_fragment")
    }
    
    public func RunRender_Default(_ vertexFunctionName: String, _ fragmentFunctionName: String, _ renderCommandEncoder: inout MTLRenderCommandEncoder, _ vertexDatas: [Vertex]) {
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        renderPipelineDescriptor.vertexFunction = vertexFunctions[vertexFunctionName]
        
        renderPipelineDescriptor.fragmentFunction = fragmentFunctions[fragmentFunctionName]
        
        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.size
        
        //uniform
        vertexDescriptor.attributes[2].format = .float4
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size
        
        vertexDescriptor.attributes[3].format = .float4
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 2
        
        vertexDescriptor.attributes[4].format = .float4
        vertexDescriptor.attributes[4].bufferIndex = 0
        vertexDescriptor.attributes[4].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 3
        
        vertexDescriptor.attributes[5].format = .float4
        vertexDescriptor.attributes[5].bufferIndex = 0
        vertexDescriptor.attributes[5].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 4
        
        //perspective
        vertexDescriptor.attributes[6].format = .float4
        vertexDescriptor.attributes[6].bufferIndex = 0
        vertexDescriptor.attributes[6].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 5
        
        vertexDescriptor.attributes[7].format = .float4
        vertexDescriptor.attributes[7].bufferIndex = 0
        vertexDescriptor.attributes[7].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 6
        
        vertexDescriptor.attributes[8].format = .float4
        vertexDescriptor.attributes[8].bufferIndex = 0
        vertexDescriptor.attributes[8].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 7
        
        vertexDescriptor.attributes[9].format = .float4
        vertexDescriptor.attributes[9].bufferIndex = 0
        vertexDescriptor.attributes[9].offset = MemoryLayout<SIMD3<Float>>.size + MemoryLayout<SIMD4<Float>>.size * 8
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        let renderPipelineState = try! self.device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        
        let vertexBuffer = self.device.makeBuffer(bytes: vertexDatas, length: MemoryLayout<Vertex>.stride * vertexDatas.count, options: [])
        
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexDatas.count)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexDatas.count)
        
        
    }
}

struct Vertex {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
    var uniform: simd_float4x4
    var perspective: simd_float4x4
}
