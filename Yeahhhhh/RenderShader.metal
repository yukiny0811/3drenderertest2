//
//  RenderShader.metal
//  Yeahhhhh
//
//  Created by クワシマ・ユウキ on 2021/02/04.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[attribute(0)]];
    float4 color [[attribute(1)]];
    
    float4 uniform1 [[attribute(2)]];
    float4 uniform2 [[attribute(3)]];
    float4 uniform3 [[attribute(4)]];
    float4 uniform4 [[attribute(5)]];
    
    float4 perspective1 [[attribute(6)]];
    float4 perspective2 [[attribute(7)]];
    float4 perspective3 [[attribute(8)]];
    float4 perspective4 [[attribute(9)]];
};

struct RasterizerData{
    float4 position [[position]];
    float4 color;
};

vertex RasterizerData test_vertex (const VertexIn vIn [[ stage_in ]]){
    RasterizerData rd;
    float4x4 uniform = float4x4(vIn.uniform1, vIn.uniform2, vIn.uniform3, vIn.uniform4);
    float4x4 perspective = float4x4(vIn.perspective1,vIn.perspective2,vIn.perspective3,vIn.perspective4);
    rd.position = perspective * uniform * float4(vIn.position, 1);
//    rd.position = uniform * float4(vIn.position, 1);
    rd.color = vIn.color;
    return rd;
}

//vertex float4 basic_vertex_shader(device VertexIn *vertices [[buffer(0)]], uint vertexID [[vertex_id]]){
//    return float4(vertices[vertexID].position, 1);
//}

fragment half4 test_fragment (RasterizerData rd [[stage_in]]){
    float4 color = rd.color;
    return half4(color.r, color.g, color.b, color.a);
}
