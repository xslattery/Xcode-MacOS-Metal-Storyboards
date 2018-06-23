//
//  ShaderTypes.h
//  metal-storyboards
//
//  Created by Xavier Slattery on 23/6/18.
//  Copyright © 2018 Xavier Slattery. All rights reserved.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#include <simd/simd.h>

enum VertexInputIndex {
	VertexInputIndexVertices = 0,
	VertexInputIndexViewportSize = 1,
};

struct VertexPC {
	simd::float3 position;
	simd::float4 color;
};

#endif /* ShaderTypes_h */
