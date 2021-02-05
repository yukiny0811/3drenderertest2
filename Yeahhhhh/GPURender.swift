//
//  GPURender.swift
//  Yeahhhhh
//
//  Created by クワシマ・ユウキ on 2021/02/04.
//

import Metal
import SceneKit
import GLKit

class GPURender {
    
    private static let cos7L6: Float = -0.86602540378
    private static let cos11L6: Float = 0.86602540378
    private static let sin7L6: Float = -0.5
    private static let sin11L6: Float = -0.5
    
    public static func Run_DrawTriangle(_ renderCommandEncoder: inout MTLRenderCommandEncoder, _ positionX: Float, _ positionY: Float, _ positionZ: Float, _ size: Float, _ color: (Float, Float, Float)) {
//        let renderPositionX = positionX * 2 - 1
//        let renderPositionY = positionY * 2 - 1
        
//        var a = SCNMatrix4()
        
        let renderPositionX = positionX
        let renderPositionY = positionY
        
//        let renderPositionX: Float = 0.0
//        let renderPositionY: Float = 0.0
        let renderPostionZ: Float = positionZ
        
//        let size: Float = 1.0
        
        let position1 = SIMD3<Float>(renderPositionX, renderPositionY + size, renderPostionZ)
        let position2 = SIMD3<Float>(renderPositionX + cos7L6 * size, renderPositionY + sin7L6 * size, renderPostionZ)
        let position3 = SIMD3<Float>(renderPositionX + cos11L6 * size, renderPositionY + sin11L6 * size, renderPostionZ)
        
        let color = SIMD4<Float>(color.0, color.1, color.2, 1)
        
        let modelMatrix1 = modelMatrix(position1.x, position1.y, position1.z)
        let modelMatrix2 = modelMatrix(position2.x, position2.y, position2.z)
        let modelMatrix3 = modelMatrix(position3.x, position3.y, position3.z)
        
        let perspective = makePerspective(width: 200, height: 200)
        
        let vertex1 = Vertex(position: position1, color: color, uniform: returnSimdMatrix(matrix: modelMatrix1), perspective: returnSimdMatrix(matrix: perspective))
        let vertex2 = Vertex(position: position2, color: color, uniform: returnSimdMatrix(matrix: modelMatrix2), perspective: returnSimdMatrix(matrix: perspective))
        let vertex3 = Vertex(position: position3, color: color, uniform: returnSimdMatrix(matrix: modelMatrix3), perspective: returnSimdMatrix(matrix: perspective))
        
        let vertexDatas = [vertex1, vertex2, vertex3]
        GPUCore.shared.RunRender_Default("test_vertex", "test_fragment", &renderCommandEncoder, vertexDatas)
    }
    
    public static func Run_DrawTetrahedron(_ renderCommandEncoder: inout MTLRenderCommandEncoder, _ positionX: Float, _ positionY: Float, _ positionZ: Float, _ size: Float, _ color: (Float, Float, Float)) {
        let renderPositionX = positionX
        let renderPositionY = positionY
        let renderPostionZ: Float = positionZ
        
        let color1 = SIMD4<Float>(color.0, color.1, color.2, 1)
        let color2 = SIMD4<Float>(0.1, 0.8, 0.4, 1)
        let color3 = SIMD4<Float>(0.5, 0.5, 0.9, 1)
        let color4 = SIMD4<Float>(0.1, 0.1, 1, 1)
        
        let position1 = SIMD3<Float>(renderPositionX, renderPositionY + size, renderPostionZ)
        let position2 = SIMD3<Float>(renderPositionX + cos7L6 * size, renderPositionY + sin7L6 * size, renderPostionZ)
        let position3 = SIMD3<Float>(renderPositionX + cos11L6 * size, renderPositionY + sin11L6 * size, renderPostionZ)
        let position4 = SIMD3<Float>(renderPositionX, renderPositionY, renderPostionZ - size)
        
        let modelMatrix1 = modelMatrix(position1.x, position1.y, position1.z)
        let modelMatrix2 = modelMatrix(position2.x, position2.y, position2.z)
        let modelMatrix3 = modelMatrix(position3.x, position3.y, position3.z)
        let modelMatrix4 = modelMatrix(position4.x, position4.y, position4.z)
        
        let perspective = makePerspective(width: 200, height: 200)
        
        let vertex1 = Vertex(position: position1, color: color1, uniform: returnSimdMatrix(matrix: modelMatrix1), perspective: returnSimdMatrix(matrix: perspective))
        let vertex2 = Vertex(position: position2, color: color1, uniform: returnSimdMatrix(matrix: modelMatrix2), perspective: returnSimdMatrix(matrix: perspective))
        let vertex3 = Vertex(position: position3, color: color1, uniform: returnSimdMatrix(matrix: modelMatrix3), perspective: returnSimdMatrix(matrix: perspective))
        
        let vertex4 = Vertex(position: position1, color: color2, uniform: returnSimdMatrix(matrix: modelMatrix1), perspective: returnSimdMatrix(matrix: perspective))
        let vertex5 = Vertex(position: position2, color: color2, uniform: returnSimdMatrix(matrix: modelMatrix2), perspective: returnSimdMatrix(matrix: perspective))
        let vertex6 = Vertex(position: position4, color: color2, uniform: returnSimdMatrix(matrix: modelMatrix4), perspective: returnSimdMatrix(matrix: perspective))
        
        let vertex7 = Vertex(position: position2, color: color3, uniform: returnSimdMatrix(matrix: modelMatrix2), perspective: returnSimdMatrix(matrix: perspective))
        let vertex8 = Vertex(position: position3, color: color3, uniform: returnSimdMatrix(matrix: modelMatrix3), perspective: returnSimdMatrix(matrix: perspective))
        let vertex9 = Vertex(position: position4, color: color3, uniform: returnSimdMatrix(matrix: modelMatrix4), perspective: returnSimdMatrix(matrix: perspective))
        
        let vertex10 = Vertex(position: position1, color: color4, uniform: returnSimdMatrix(matrix: modelMatrix1), perspective: returnSimdMatrix(matrix: perspective))
        let vertex11 = Vertex(position: position3, color: color4, uniform: returnSimdMatrix(matrix: modelMatrix3), perspective: returnSimdMatrix(matrix: perspective))
        let vertex12 = Vertex(position: position4, color: color4, uniform: returnSimdMatrix(matrix: modelMatrix4), perspective: returnSimdMatrix(matrix: perspective))
        
        let vertexDatas = [vertex1, vertex2, vertex3, vertex4, vertex5, vertex6, vertex7, vertex8, vertex9, vertex10, vertex11, vertex12]
        GPUCore.shared.RunRender_Default("test_vertex", "test_fragment", &renderCommandEncoder, vertexDatas)
    }
    
    private static func modelMatrix(_ x: Float, _ y: Float, _ z: Float) -> GLKMatrix4{
        let matrix = GLKMatrix4MakeTranslation(0, 0, 0)
//        let matrix = GLKMatrix4MakeRotation(1, Float.random(in: -1...1), Float.random(in: -1...1), Float.random(in: -1...1))
//        let matrix = GLKMatrix4MakeRotation(2, 0, 0, 0)
        var parentViewMatrix = GLKMatrix4MakeTranslation(0, 0, -2)
        parentViewMatrix = GLKMatrix4RotateX(parentViewMatrix, 0.8)
        let resultMatrix = GLKMatrix4Multiply(parentViewMatrix, matrix)
        return resultMatrix
    }
    
    private static func returnSimdMatrix(matrix: GLKMatrix4) -> simd_float4x4 {
        let row1 = simd_float4(matrix.m00, matrix.m01, matrix.m02, matrix.m03)
        let row2 = simd_float4(matrix.m10, matrix.m11, matrix.m12, matrix.m13)
        let row3 = simd_float4(matrix.m20, matrix.m21, matrix.m22, matrix.m23)
        let row4 = simd_float4(matrix.m30, matrix.m31, matrix.m32, matrix.m33)
        return simd_float4x4(row1, row2, row3, row4)
    }
    
    private static func makePerspective(width: Float, height: Float) -> GLKMatrix4 {
        let matrix = GLKMatrix4MakePerspective(1.48, 1, 0.0001, 10000)
        return matrix
    }
}
