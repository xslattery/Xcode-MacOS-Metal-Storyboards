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

//////////////////////////

struct VertexInputPT {
	float3 position [[attribute(0)]];
	float2 textureCoord [[attribute(1)]];
};

struct RasterDataPT {
	float4 clipSpacePosition [[position]];
	float2 textureCoord;
};

struct FragOutPT {
	float4 color [[color(0)]] ;
	float depth [[depth(less)]];
};

vertex RasterDataPT vertexShaderPT ( VertexInputPT in [[stage_in]], constant ViewProjectionMatrices *vp [[buffer(VertexInputIndexVP)]]  ) {
	RasterDataPT result;
	
	result.clipSpacePosition = vp->projectionMatrix * vp->viewMatrix * float4(in.position, 1.0);
	result.textureCoord = in.textureCoord;
	
	return result;
}

fragment FragOutPT fragmentShaderPT ( RasterDataPT input [[stage_in]], texture2d<half> colorTexture [[texture(FragmentInputIndexTexture)]] ) {
	FragOutPT result;
	
	constexpr sampler textureSampler (mag_filter::linear, min_filter::linear);
	const half4 colorSample = colorTexture.sample(textureSampler, input.textureCoord);
	result.color = float4(colorSample);
	
	if (colorSample.a < 0.01) result.depth = 1.0;
	else result.depth = input.clipSpacePosition.z;
	
	return result;
}