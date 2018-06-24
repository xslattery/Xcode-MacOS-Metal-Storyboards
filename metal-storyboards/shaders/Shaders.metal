//
//  Shaders.metal
//  metal-storyboards
//
//  Created by Xavier Slattery on 23/6/18.
//  Copyright © 2018 Xavier Slattery. All rights reserved.
//

#include <metal_stdlib>
#include "ShaderTypes.h"

using namespace metal;

struct VertexInputPC {
	float3 position [[attribute(0)]];
	float4 color [[attribute(1)]];
};

struct RasterDataPC {
	float4 clipSpacePosition [[position]];
	float4 color;
};

vertex RasterDataPC vertexShaderPC ( VertexInputPC in [[stage_in]], constant ViewProjectionMatrices *vp [[buffer(VertexInputIndexVP)]]  ) {
	RasterDataPC result;
	
	result.clipSpacePosition = vp->projectionMatrix * vp->viewMatrix * float4(in.position, 1.0);
	result.color = in.color;
	
	return result;
}

fragment float4 fragmentShaderPC ( RasterDataPC input [[stage_in]] ) {
	return input.color;
}
