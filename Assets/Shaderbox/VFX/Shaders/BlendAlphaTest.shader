// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Curl/Basic/FX/BlendAlpha"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HDR][Header(_____Base_____)] _MainColor( "MainColor", Color ) = ( 1, 1, 1, 0 )
		_OpacityStrength( "OpacityStrength", Range( 0, 6 ) ) = 1
		_TextureIntensity( "TextureIntensity", Range( 0, 15 ) ) = 1
		_FadeDistance( "FadeDistance", Range( 0, 2 ) ) = 0
		_CameraOffset( "CameraOffset", Float ) = 0
		_CameraDepthFadeOffset( "CameraDepthFadeOffset", Float ) = 0
		_CameraDepthFade( "CameraDepthFade", Float ) = 0
		[Header(_____Main_____)] _MainTex( "MainTex", 2D ) = "white" {}
		[Toggle] _StylizeMainShape( "StylizeMainShape", Float ) = 0
		_OpacityPower( "OpacityPower", Range( 0, 55 ) ) = 1
		_StylizeShape( "StylizeShape", Range( 0.01, 1 ) ) = 0.01
		[Toggle] _Main90degreeUVFlip( "Main90degree UV Flip", Float ) = 0
		[Toggle] _MainUVSwitch( "MainUVSwitch", Float ) = 0
		[Toggle] _UseMainUVCustom1ZW( "UseMainUVCustom1ZW", Float ) = 0
		[Toggle] _MainRIsAlpha( "Main R Is Alpha", Float ) = 0
		[Toggle] _MainRBGOffset( "MainRBGOffset", Float ) = 1
		_MainFlowX( "MainFlow X", Float ) = 0
		_MainFlowY( "MainFlow Y", Float ) = 0
		[Toggle] _MainClampX( "MainClamp X", Float ) = 0
		[Toggle] _MainClampY( "MainClamp Y", Float ) = 0
		_MaskTex( "MaskTex", 2D ) = "white" {}
		_MaskFlowX( "MaskFlow X", Float ) = 0
		_MaskFlowY( "MaskFlow Y", Float ) = 0
		_MainOffsetU( "MainOffset U", Range( -0.025, 0.025 ) ) = 0.015
		_MainOffsetV( "MainOffset V", Range( -0.025, 0.025 ) ) = 0.015
		[Header(_____Dissolve_____)] _DissolveTex( "DissolveTex", 2D ) = "white" {}
		[Toggle] _MainTexRDissolve( "MainTex R Dissolve", Float ) = 0
		[Toggle] _UseManual_DebugDissolve( "UseManual_DebugDissolve", Float ) = 1
		_ManualDissolve( "ManualDissolve", Range( 0, 1 ) ) = 1
		_SmoothDissolve( "SmoothDissolve", Range( 0, 15 ) ) = 1
		_DissolveFlowX( "DissolveFlow X", Float ) = 0
		_DissolveFlowY( "DissolveFlow Y", Float ) = 0
		[Header(____NoiseDistortion____)] _NoiseTex( "NoiseTex", 2D ) = "white" {}
		[Toggle( _USENOISE_ON )] _UseNoise( "Use Noise", Float ) = 0
		[Toggle( _USECUSTOM1YDISTORTION_ON )] _UseCustom1YDistortion( "Use Custom1Y Distortion", Float ) = 0
		_MainTexDistortion( "MainTex Distortion", Float ) = 0
		_NoiseFlowX( "NoiseFlow X", Float ) = 0
		_NoiseFlowY( "NoiseFlow Y", Float ) = 0
		_NoiseAffectsXAxis( "Noise Affects X Axis", Float ) = 0
		_NoiseAffectsYAxis( "Noise Affects Y Axis", Float ) = 0
		_NoiseMask( "NoiseMask", 2D ) = "white" {}
		[Header(____Color____)] _ColorTex( "ColorTex", 2D ) = "white" {}
		[Toggle( _USECOLOR_ON )] _UseColor( "Use Color", Float ) = 0
		_Desaturate( "Desaturate", Float ) = 0
		[Toggle] _Color90degreeUVFlip( "Color 90degree UV Flip", Float ) = 0
		_ColorIntensity( "Color Intensity", Range( 0, 1 ) ) = 0
		_ColorPower( "ColorPower", Float ) = 1
		_ColorFlowX( "ColorFlow X", Float ) = 0
		_ColorFlowY( "ColorFlow Y", Float ) = 0
		[Toggle] _ColorClampX( "ColorClamp X", Float ) = 0
		[Toggle] _ColorClampY( "ColorClamp Y", Float ) = 0


		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		//[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		//[HideInInspector][ToggleUI] _ReceiveShadows("Receive Shadows", Float) = 1.0

		//[HideInInspector] _AlphaClip("__clip", Float) = 0.0
	}

	SubShader
	{
		LOD 0

		

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" "UniversalMaterialType"="Unlit" "AlwaysRenderMotionVectors"="false" }

		Cull [_CullMode]
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#if ( SHADER_TARGET > 35 ) && defined( SHADER_API_GLES3 )
			#error For WebGL2/GLES3, please set your shader target to 3.5 via SubShader options. URP shaders in ASE use target 4.5 by default.
		#endif

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForwardOnly" }

			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3

			#pragma multi_compile_fragment _ DEBUG_DISPLAY

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_UNLIT

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Debug/Debugging3D.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceData.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON
			#pragma shader_feature_local _USECOLOR_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 positionWSAndFogFactor : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_color : COLOR;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _ColorTex;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord5 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord4.z = customEye207;
				
				output.ase_texcoord3 = input.ase_texcoord;
				output.ase_texcoord4.xy = input.ase_texcoord1.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				float fogFactor = 0;
				#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
					fogFactor = ComputeFogFactor(vertexInput.positionCS.z);
				#endif

				output.positionCS = vertexInput.positionCS;
				output.positionWSAndFogFactor = float4( vertexInput.positionWS, fogFactor );
				output.normalWS = normalInput.normalWS;
				output.tangentWS = half4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag ( PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined( _SURFACE_TYPE_TRANSPARENT )
					const bool isTransparent = true;
				#else
					const bool isTransparent = false;
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					float4 shadowCoord = TransformWorldToShadowCoord( input.positionWSAndFogFactor.xyz );
				#else
					float4 shadowCoord = float4(0, 0, 0, 0);
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWSAndFogFactor.xyz;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				half3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ShadowCoord = shadowCoord;
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				float2 uv_MainTex = input.ase_texcoord3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord4.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord3;
				texCoord127.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord3.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float temp_output_191_0 = (temp_output_52_0).x;
				float temp_output_190_0 = (temp_output_52_0).y;
				float2 appendResult196 = (float2(( _MainOffsetU + temp_output_191_0 ) , ( temp_output_190_0 + _MainOffsetV )));
				float2 appendResult198 = (float2(( temp_output_191_0 + ( _MainOffsetU * 2.0 ) ) , ( temp_output_190_0 + ( _MainOffsetV * 2.0 ) )));
				float4 tex2DNode204 = tex2D( _MainTex, appendResult198 );
				float4 appendResult205 = (float4(tex2DNode10.r , tex2D( _MainTex, appendResult196 ).g , tex2DNode204.b , tex2DNode204.a));
				float4 temp_cast_2 = (_StylizeShape).xxxx;
				float3 desaturateInitialColor171 = step( temp_cast_2 , (( _MainRBGOffset )?( appendResult205 ):( float4( tex2DNode10.rgb , 0.0 ) )) ).xyz;
				float desaturateDot171 = dot( desaturateInitialColor171, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar171 = lerp( desaturateInitialColor171, desaturateDot171.xxx, 1.0 );
				float3 temp_cast_7 = (1.0).xxx;
				float2 uv_ColorTex = input.ase_texcoord3.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
				float2 appendResult132 = (float2((uv_ColorTex.y).x , (uv_ColorTex.x).x));
				float temp_output_136_0 = ((( _Color90degreeUVFlip )?( appendResult132 ):( uv_ColorTex ))).x;
				float temp_output_135_0 = ((( _Color90degreeUVFlip )?( appendResult132 ):( uv_ColorTex ))).y;
				float2 appendResult142 = (float2((( _ColorClampX )?( saturate( temp_output_136_0 ) ):( temp_output_136_0 )) , (( _ColorClampY )?( saturate( temp_output_135_0 ) ):( temp_output_135_0 ))));
				float2 appendResult148 = (float2(_ColorFlowX , _ColorFlowY));
				float3 desaturateInitialColor155 = tex2D( _ColorTex, ( appendResult142 + ( appendResult148 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot155 = dot( desaturateInitialColor155, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar155 = lerp( desaturateInitialColor155, desaturateDot155.xxx, _Desaturate );
				float3 saferPower157 = abs( desaturateVar155 );
				float3 temp_cast_9 = (_ColorPower).xxx;
				#ifdef _USECOLOR_ON
				float3 staticSwitch162 = saturate( ( pow( saferPower157 , temp_cast_9 ) + _ColorIntensity ) );
				#else
				float3 staticSwitch162 = temp_cast_7;
				#endif
				float3 ColorMix165 = staticSwitch162;
				
				float2 uv_DissolveTex = input.ase_texcoord3.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord3;
				texCoord29.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord5;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord4.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( ( _MainColor * ( (( _StylizeMainShape )?( float4( desaturateVar171 , 0.0 ) ):( (( _MainRBGOffset )?( appendResult205 ):( float4( tex2DNode10.rgb , 0.0 ) )) )) * _TextureIntensity ) * float4( ColorMix165 , 0.0 ) ) * input.ase_color ).rgb;
				float Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
					float AlphaClipThresholdShadow = 0.5;
				#endif
				

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(MAIN_LIGHT_CALCULATE_SHADOWS) && defined(ASE_CHANGES_WORLD_POS)
					ShadowCoord = TransformWorldToShadowCoord( PositionWS );
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = input.positionCS;
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.normalWS = NormalWS;
				inputData.viewDirectionWS = ViewDirWS;

				#if defined(_SCREEN_SPACE_OCCLUSION) && !defined(_SURFACE_TYPE_TRANSPARENT)
					float2 normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);
					AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion(normalizedScreenSpaceUV);
					Color.rgb *= aoFactor.directAmbientOcclusion;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = InitializeInputDataFog(float4(inputData.positionWS, 1.0), input.positionWSAndFogFactor.w);
				#endif

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(input.positionCS, Color);
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						Color.rgb = MixFogColor(Color.rgb, half3(0,0,0), inputData.fogCoord);
					#else
						Color.rgb = MixFog(Color.rgb, inputData.fogCoord);
					#endif
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				#if defined( ASE_OPAQUE_KEEP_ALPHA )
					return half4( Color, Alpha );
				#else
					return half4( Color, OutputAlpha( Alpha, isTransparent ) );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord2 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord1.z = customEye207;
				
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				float2 uv_MainTex = input.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord;
				texCoord127.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float2 uv_DissolveTex = input.ase_texcoord.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord;
				texCoord29.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord2;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord1.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				float Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#if defined( _ALPHATEST_ON )
					AlphaDiscard( Alpha, AlphaClipThreshold );
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			int _ObjectId;
			int _PassValue;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord2 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord1.z = customEye207;
				
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_MainTex = input.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord;
				texCoord127.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float2 uv_DissolveTex = input.ase_texcoord.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord;
				texCoord29.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord2;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord1.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				surfaceDescription.Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					surfaceDescription.AlphaClipThreshold = _Cutoff;
				#endif

				#ifdef _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				half4 outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				return outColor;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON


			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			float4 _SelectionID;

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord2 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord1.z = customEye207;
				
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord1.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				output.positionCS = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_MainTex = input.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord;
				texCoord127.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float2 uv_DissolveTex = input.ase_texcoord.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord;
				texCoord29.xy = input.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord2;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord1.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				surfaceDescription.Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					surfaceDescription.AlphaClipThreshold = _Cutoff;
				#endif

				#ifdef _ALPHATEST_ON
					clip(surfaceDescription.Alpha - surfaceDescription.AlphaClipThreshold);
				#endif

				half4 outColor = 0;
				outColor = unity_SelectionID;

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormalsOnly" }

			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

        	#pragma multi_compile_instancing
        	#define _SURFACE_TYPE_TRANSPARENT 1
        	#define _RECEIVE_SHADOWS_OFF
        	#define ASE_VERSION 19908
        	#define ASE_SRP_VERSION 170004
        	#define REQUIRE_DEPTH_TEXTURE 1


        	#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT

			#pragma vertex vert
			#pragma fragment frag

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_NORMAL_WS

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            #if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				half3 normalWS : TEXCOORD0;
				float4 ase_color : COLOR;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord3 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord2.z = customEye207;
				
				output.ase_color = input.ase_color;
				output.ase_texcoord1 = input.ase_texcoord;
				output.ase_texcoord2.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord2.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS );

				output.positionCS = vertexInput.positionCS;
				output.normalWS = normalInput.normalWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_color = input.ase_color;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			void frag(PackedVaryings input
						, out half4 outNormalWS : SV_Target0
						#if defined( ASE_DEPTH_WRITE_ON )
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				half3 NormalWS = normalize( input.normalWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );

				float2 uv_MainTex = input.ase_texcoord1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord1;
				texCoord127.xy = input.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord1.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float2 uv_DissolveTex = input.ase_texcoord1.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord1;
				texCoord29.xy = input.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord1.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord3;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord2.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				float Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(NormalWS);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					outNormalWS = half4(NormalizeNormalPerPixel( NormalWS ), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "MotionVectors"
			Tags { "LightMode"="MotionVectors" }

			ColorMask RG

			HLSLPROGRAM

			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

            #define SHADERPASS SHADERPASS_MOTION_VECTORS

            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
		    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
		    #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
				#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MotionVectorsCommon.hlsl"

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 positionOld : TEXCOORD4;
				#if _ADD_PRECOMPUTED_VELOCITY
					float3 alembicMotionVector : TEXCOORD5;
				#endif
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float4 positionCSNoJitter : TEXCOORD0;
				float4 previousPositionCSNoJitter : TEXCOORD1;
				float3 positionWS : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord5 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord4.z = customEye207;
				
				output.ase_color = input.ase_color;
				output.ase_texcoord3 = input.ase_texcoord;
				output.ase_texcoord4.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				#if defined(APLICATION_SPACE_WARP_MOTION)
					output.positionCSNoJitter = mul(_NonJitteredViewProjMatrix, mul(UNITY_MATRIX_M, input.positionOS));
					output.positionCS = output.positionCSNoJitter;
				#else
					output.positionCS = vertexInput.positionCS;
					output.positionCSNoJitter = mul(_NonJitteredViewProjMatrix, mul(UNITY_MATRIX_M, input.positionOS));
				#endif

				float4 prevPos = ( unity_MotionVectorsParams.x == 1 ) ? float4( input.positionOld, 1 ) : input.positionOS;

				#if _ADD_PRECOMPUTED_VELOCITY
					prevPos = prevPos - float4(input.alembicMotionVector, 0);
				#endif

				output.previousPositionCSNoJitter = mul( _PrevViewProjMatrix, mul( UNITY_PREV_MATRIX_M, prevPos ) );
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}

			half4 frag(	PackedVaryings input
				#if defined( ASE_DEPTH_WRITE_ON )
				,out float outputDepth : ASE_SV_DEPTH
				#endif
				 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				float3 PositionWS = input.positionWS;
				float3 PositionRWS = GetCameraRelativePositionWS( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;

				float2 uv_MainTex = input.ase_texcoord3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord4.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord3;
				texCoord127.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord3.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float2 uv_DissolveTex = input.ase_texcoord3.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord3;
				texCoord29.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord5;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord4.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				float Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined( ASE_CHANGES_WORLD_POS )
					float3 positionOS = mul( GetWorldToObjectMatrix(),  float4( PositionWS, 1.0 ) ).xyz;
					float3 previousPositionWS = mul( GetPrevObjectToWorldMatrix(),  float4( positionOS, 1.0 ) ).xyz;
					input.positionCSNoJitter = mul( _NonJitteredViewProjMatrix, float4( PositionWS, 1.0 ) );
					input.previousPositionCSNoJitter = mul( _PrevViewProjMatrix, float4( previousPositionWS, 1.0 ) );
				#endif

				#if defined( LOD_FADE_CROSSFADE )
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				#if defined(APLICATION_SPACE_WARP_MOTION)
					return float4( CalcAswNdcMotionVectorFromCsPositions( input.positionCSNoJitter, input.previousPositionCSNoJitter ), 1 );
				#else
					return float4( CalcNdcMotionVectorFromCsPositions( input.positionCSNoJitter, input.previousPositionCSNoJitter ), 0, 0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define _RECEIVE_SHADOWS_OFF
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION 170004
			#define REQUIRE_DEPTH_TEXTURE 1


			// Deferred Rendering Path does not support the OpenGL-based graphics API:
			// Desktop OpenGL, OpenGL ES 3.0, WebGL 2.0.
			#pragma exclude_renderers glcore gles3 

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local _USECUSTOM1YDISTORTION_ON
			#pragma shader_feature_local _USENOISE_ON
			#pragma shader_feature_local _USECOLOR_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float3 positionWS : TEXCOORD0;
				half3 normalWS : TEXCOORD1;
				half4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_color : COLOR;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _ColorTex_ST;
			float4 _MainColor;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _NoiseMask_ST;
			float4 _NoiseTex_ST;
			float4 _DissolveTex_ST;
			float _ColorFlowX;
			float _ColorFlowY;
			float _Desaturate;
			float _ColorPower;
			float _ColorIntensity;
			float _MainRIsAlpha;
			float _OpacityPower;
			float _MainTexRDissolve;
			float _DissolveFlowX;
			float _DissolveFlowY;
			float _SmoothDissolve;
			float _UseManual_DebugDissolve;
			float _ManualDissolve;
			float _MaskFlowX;
			float _MaskFlowY;
			float _OpacityStrength;
			float _FadeDistance;
			float _ColorClampY;
			float _CameraOffset;
			float _ColorClampX;
			float _CameraDepthFade;
			float _StylizeMainShape;
			float _MainRBGOffset;
			float _MainClampX;
			float _Main90degreeUVFlip;
			float _UseMainUVCustom1ZW;
			float _MainUVSwitch;
			float _MainClampY;
			float _MainFlowX;
			float _Color90degreeUVFlip;
			float _MainFlowY;
			float _NoiseFlowX;
			float _NoiseFlowY;
			float _NoiseAffectsXAxis;
			float _NoiseAffectsYAxis;
			float _MainOffsetU;
			float _MainOffsetV;
			float _StylizeShape;
			float _TextureIntensity;
			float _MainTexDistortion;
			float _CameraDepthFadeOffset;
			float _AlphaClip;
			float _Cutoff;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _MainTex;
			sampler2D _NoiseTex;
			sampler2D _NoiseMask;
			sampler2D _ColorTex;
			sampler2D _DissolveTex;
			sampler2D _MaskTex;


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float3 CameraOffset211( float3 vertexWorldPos, float3 cameraWorldPos, float offsetAmount )
			{
				float3 viewDirection = cameraWorldPos - vertexWorldPos;
				float3 normalizedViewDirection = normalize(viewDirection + 1e-6f);
				float3 worldOffset = normalizedViewDirection * offsetAmount;
				return worldOffset;
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float3 ase_positionWS = TransformObjectToWorld( ( input.positionOS ).xyz );
				float3 vertexWorldPos211 = ase_positionWS;
				float3 cameraWorldPos211 = _WorldSpaceCameraPos;
				float offsetAmount211 = _CameraOffset;
				float3 localCameraOffset211 = CameraOffset211( vertexWorldPos211 , cameraWorldPos211 , offsetAmount211 );
				
				float3 vertexPos33 = input.positionOS.xyz;
				float4 ase_positionCS33 = TransformObjectToHClip( ( vertexPos33 ).xyz );
				float4 screenPos33 = ComputeScreenPos( ase_positionCS33 );
				output.ase_texcoord5 = screenPos33;
				float3 customSurfaceDepth207 = input.positionOS.xyz;
				float customEye207 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth207)).z;
				output.ase_texcoord4.z = customEye207;
				
				output.ase_texcoord3 = input.ase_texcoord;
				output.ase_texcoord4.xy = input.ase_texcoord1.xy;
				output.ase_color = input.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = localCameraOffset211;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				output.positionCS = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalInput.normalWS;
				output.tangentWS = half4( normalInput.tangentWS, ( input.tangentOS.w > 0.0 ? 1.0 : -1.0 ) * GetOddNegativeScale() );;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				half3 normalOS : NORMAL;
				half4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_color = input.ase_color;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			FragmentOutput frag ( PackedVaryings input
								#if defined( ASE_DEPTH_WRITE_ON )
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				// @diogo: mikktspace compliant
				float renormFactor = 1.0 / max( FLT_MIN, length( input.normalWS ) );

				float3 PositionWS = input.positionWS;
				float3 ViewDirWS = GetWorldSpaceNormalizeViewDir( PositionWS );
				float4 ScreenPosNorm = float4( GetNormalizedScreenSpaceUV( input.positionCS ), input.positionCS.zw );
				float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, input.positionCS.z ) * input.positionCS.w;
				float4 ScreenPos = ComputeScreenPos( ClipPos );
				float3 TangentWS = input.tangentWS.xyz * renormFactor;
				float3 BitangentWS = cross( input.normalWS, input.tangentWS.xyz ) * input.tangentWS.w * renormFactor;
				float3 NormalWS = input.normalWS * renormFactor;

				float2 uv_MainTex = input.ase_texcoord3.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 uv2_MainTex = input.ase_texcoord4.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 texCoord184 = input.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult96 = (float2(((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).y , ((( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex ))).x));
				float temp_output_98_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).x;
				float temp_output_99_0 = ((( _Main90degreeUVFlip )?( appendResult96 ):( (( _UseMainUVCustom1ZW )?( ( (( _MainUVSwitch )?( uv2_MainTex ):( uv_MainTex )) + texCoord184 ) ):( uv_MainTex )) ))).y;
				float2 appendResult104 = (float2((( _MainClampX )?( saturate( temp_output_98_0 ) ):( temp_output_98_0 )) , (( _MainClampY )?( saturate( temp_output_99_0 ) ):( temp_output_99_0 ))));
				float2 appendResult88 = (float2(_MainFlowX , _MainFlowY));
				float4 texCoord127 = input.ase_texcoord3;
				texCoord127.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _USECUSTOM1YDISTORTION_ON
				float staticSwitch126 = ( _MainTexDistortion * texCoord127.w );
				#else
				float staticSwitch126 = _MainTexDistortion;
				#endif
				float2 temp_cast_0 = (0.0).xx;
				float2 uv_NoiseTex = input.ase_texcoord3.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
				float2 appendResult109 = (float2(_NoiseFlowX , _NoiseFlowY));
				float4 tex2DNode114 = tex2D( _NoiseTex, ( uv_NoiseTex + ( appendResult109 * _TimeParameters.x ) ) );
				float2 appendResult119 = (float2(_NoiseAffectsXAxis , _NoiseAffectsYAxis));
				float2 uv_NoiseMask = input.ase_texcoord3.xy * _NoiseMask_ST.xy + _NoiseMask_ST.zw;
				#ifdef _USENOISE_ON
				float2 staticSwitch124 = ( ( (( tex2DNode114 * tex2DNode114.a )).r * appendResult119 ) * tex2D( _NoiseMask, uv_NoiseMask ).r );
				#else
				float2 staticSwitch124 = temp_cast_0;
				#endif
				float2 temp_output_52_0 = ( ( appendResult104 + ( appendResult88 * _TimeParameters.x ) ) + ( staticSwitch126 * staticSwitch124 ) );
				float4 tex2DNode10 = tex2D( _MainTex, temp_output_52_0 );
				float temp_output_191_0 = (temp_output_52_0).x;
				float temp_output_190_0 = (temp_output_52_0).y;
				float2 appendResult196 = (float2(( _MainOffsetU + temp_output_191_0 ) , ( temp_output_190_0 + _MainOffsetV )));
				float2 appendResult198 = (float2(( temp_output_191_0 + ( _MainOffsetU * 2.0 ) ) , ( temp_output_190_0 + ( _MainOffsetV * 2.0 ) )));
				float4 tex2DNode204 = tex2D( _MainTex, appendResult198 );
				float4 appendResult205 = (float4(tex2DNode10.r , tex2D( _MainTex, appendResult196 ).g , tex2DNode204.b , tex2DNode204.a));
				float4 temp_cast_2 = (_StylizeShape).xxxx;
				float3 desaturateInitialColor171 = step( temp_cast_2 , (( _MainRBGOffset )?( appendResult205 ):( float4( tex2DNode10.rgb , 0.0 ) )) ).xyz;
				float desaturateDot171 = dot( desaturateInitialColor171, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar171 = lerp( desaturateInitialColor171, desaturateDot171.xxx, 1.0 );
				float3 temp_cast_7 = (1.0).xxx;
				float2 uv_ColorTex = input.ase_texcoord3.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
				float2 appendResult132 = (float2((uv_ColorTex.y).x , (uv_ColorTex.x).x));
				float temp_output_136_0 = ((( _Color90degreeUVFlip )?( appendResult132 ):( uv_ColorTex ))).x;
				float temp_output_135_0 = ((( _Color90degreeUVFlip )?( appendResult132 ):( uv_ColorTex ))).y;
				float2 appendResult142 = (float2((( _ColorClampX )?( saturate( temp_output_136_0 ) ):( temp_output_136_0 )) , (( _ColorClampY )?( saturate( temp_output_135_0 ) ):( temp_output_135_0 ))));
				float2 appendResult148 = (float2(_ColorFlowX , _ColorFlowY));
				float3 desaturateInitialColor155 = tex2D( _ColorTex, ( appendResult142 + ( appendResult148 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot155 = dot( desaturateInitialColor155, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar155 = lerp( desaturateInitialColor155, desaturateDot155.xxx, _Desaturate );
				float3 saferPower157 = abs( desaturateVar155 );
				float3 temp_cast_9 = (_ColorPower).xxx;
				#ifdef _USECOLOR_ON
				float3 staticSwitch162 = saturate( ( pow( saferPower157 , temp_cast_9 ) + _ColorIntensity ) );
				#else
				float3 staticSwitch162 = temp_cast_7;
				#endif
				float3 ColorMix165 = staticSwitch162;
				
				float2 uv_DissolveTex = input.ase_texcoord3.xy * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
				float2 appendResult53 = (float2(_DissolveFlowX , _DissolveFlowY));
				float temp_output_10_0_g2 = _SmoothDissolve;
				float4 texCoord29 = input.ase_texcoord3;
				texCoord29.xy = input.ase_texcoord3.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult4_g2 = lerp( temp_output_10_0_g2 , -1.0 , (( _UseManual_DebugDissolve )?( _ManualDissolve ):( texCoord29.z )));
				float2 uv_MaskTex = input.ase_texcoord3.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
				float2 appendResult60 = (float2(_MaskFlowX , _MaskFlowY));
				float4 screenPos33 = input.ase_texcoord5;
				float4 ase_positionSSNorm = screenPos33 / screenPos33.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float screenDepth33 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_positionSSNorm.xy ),_ZBufferParams);
				float distanceDepth33 = abs( ( screenDepth33 - LinearEyeDepth( ase_positionSSNorm.z,_ZBufferParams ) ) / ( _FadeDistance ) );
				float customEye207 = input.ase_texcoord4.z;
				float cameraDepthFade207 = (( customEye207 -_ProjectionParams.y - _CameraDepthFadeOffset ) / _CameraDepthFade);
				

				float3 Color = ( ( _MainColor * ( (( _StylizeMainShape )?( float4( desaturateVar171 , 0.0 ) ):( (( _MainRBGOffset )?( appendResult205 ):( float4( tex2DNode10.rgb , 0.0 ) )) )) * _TextureIntensity ) * float4( ColorMix165 , 0.0 ) ) * input.ase_color ).rgb;
				float Alpha = ( ( input.ase_color.a * ( ( ( saturate( ( (( _MainRIsAlpha )?( tex2DNode10.r ):( tex2DNode10.a )) * _OpacityPower ) ) * saturate( ( ( (( _MainTexRDissolve )?( tex2DNode10.r ):( tex2D( _DissolveTex, ( uv_DissolveTex + ( appendResult53 * _TimeParameters.x ) ) ).r )) * temp_output_10_0_g2 ) - lerpResult4_g2 ) ) ) * tex2D( _MaskTex, ( uv_MaskTex + ( appendResult60 * _TimeParameters.x ) ) ).r ) * _OpacityStrength ) ) * saturate( distanceDepth33 ) * saturate( cameraDepthFade207 ) );
				#if defined( _ALPHATEST_ON )
					float AlphaClipThreshold = _Cutoff;
					float AlphaClipThresholdShadow = 0.5;
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					input.positionCS.z = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = PositionWS;
				inputData.positionCS = input.positionCS;
				inputData.normalizedScreenSpaceUV = ScreenPosNorm.xy;
				inputData.normalWS = NormalWS;
				inputData.viewDirectionWS = ViewDirWS;

				#if defined(_DBUFFER)
					ApplyDecalToBaseColor(input.positionCS, Color);
				#endif

				#if defined( ASE_DEPTH_WRITE_ON )
					outputDepth = input.positionCS.z;
				#endif

				SurfaceData surfaceData = (SurfaceData)0;
				surfaceData.albedo = Color;
				surfaceData.alpha = Alpha;

			#if defined( _SCREEN_SPACE_OCCLUSION ) // GBuffer never has transparents
				float2 normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV( input.positionCS );
				AmbientOcclusionFactor aoFactor = GetScreenSpaceAmbientOcclusion( normalizedScreenSpaceUV );
				surfaceData.occlusion = aoFactor.directAmbientOcclusion;
			#else
				surfaceData.occlusion = 1;
			#endif

				return SurfaceDataToGbuffer( surfaceData, inputData, float3( 0, 0, 0 ), kLightingInvalid );
			}

			ENDHLSL
		}
		
	}
	
	CustomEditor "UnityEditor.ShaderGraphUnlitGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback "Hidden/InternalErrorShader"
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;128;-4672,-2096;Inherit;False;2319.701;921.9366;UV Calculation;3;143;133;129;UV Calculation;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;106;-6960,-400;Inherit;False;2175.701;882.2383;;24;124;126;121;123;122;119;118;120;127;117;116;115;114;113;112;111;110;109;108;107;175;176;125;177;Noise Distortion;0.9811321,0,0.6834888,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;129;-4336,-2048;Inherit;False;703.2739;423.753;90 degree flip;4;134;132;131;130;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;107;-6912,-48;Inherit;False;Property;_NoiseFlowX;NoiseFlow X;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;108;-6912,32;Inherit;False;Property;_NoiseFlowY;NoiseFlow Y;41;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;-4608,-1920;Inherit;False;0;153;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;167;-8128,-1600;Inherit;False;3191.498;662.0532;;17;104;102;103;101;100;99;98;97;96;95;94;105;184;185;186;182;183;Main;0.4329505,1,0,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;109;-6704,-32;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;110;-6576,-64;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;130;-4288,-1792;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;131;-4288,-1856;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;185;-7680,-1360;Inherit;False;1;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;111;-6544,32;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;112;-6896,-192;Inherit;False;0;114;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;132;-4128,-1856;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;105;-7680,-1504;Inherit;False;0;10;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;133;-3648,-2032;Inherit;False;1221.898;793.41;Clamping Session;7;142;141;140;139;138;136;135;;0.5566038,0.5566038,0.5566038,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;113;-6480,-176;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;134;-3920,-1984;Inherit;True;Property;_Color90degreeUVFlip;Color 90degree UV Flip;48;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;184;-7408,-1152;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;182;-7344,-1344;Inherit;False;Property;_MainUVSwitch;MainUVSwitch;12;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;137;-2096,-1840;Inherit;False;2278.02;624.3311;;13;162;161;160;159;158;157;156;155;154;153;152;151;148;Color;0,0.06488371,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;183;-7072,-1248;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;94;-6544,-1328;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;95;-6528,-1408;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;114;-6288,-208;Inherit;True;Property;_NoiseTex;NoiseTex;36;1;[Header];Create;True;1;____NoiseDistortion____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;135;-3408,-1744;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;136;-3376,-1920;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;138;-3232,-1632;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;-3200,-1840;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;-2192,-1632;Inherit;False;Property;_ColorFlowX;ColorFlow X;51;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;-2176,-1552;Inherit;False;Property;_ColorFlowY;ColorFlow Y;52;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;115;-5936,-160;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;116;-5920,-16;Inherit;False;Property;_NoiseAffectsXAxis;Noise Affects X Axis;42;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;117;-5904,64;Inherit;False;Property;_NoiseAffectsYAxis;Noise Affects Y Axis;43;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;140;-3008,-1904;Inherit;False;Property;_ColorClampX;ColorClamp X;53;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;141;-3008,-1760;Inherit;False;Property;_ColorClampY;ColorClamp Y;54;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;-2000,-1664;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;-2160,-1472;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;218;-4464,-256;Inherit;False;1364;673.3333;;13;24;29;25;41;56;57;55;54;53;59;58;178;43;Dissolve;0,0.6496027,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;96;-6384,-1408;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;186;-7024,-1488;Inherit;False;Property;_UseMainUVCustom1ZW;UseMainUVCustom1ZW;13;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;92;-5584,-864;Inherit;False;718.2871;382.1315;;6;91;90;89;88;87;86;Flow;0.4434001,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;189;-4528,-1232;Inherit;False;1355.43;730.4116;;13;202;201;199;198;197;196;195;194;193;192;191;190;200;RGB Offset;0.8018868,0.03530312,0.03530312,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;118;-5760,-176;Inherit;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;119;-5632,0;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;176;-6320,176;Inherit;False;0;175;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;142;-2688,-1824;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;-1856,-1616;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-4400,-64;Inherit;False;Property;_DissolveFlowX;DissolveFlow X;34;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-4400,16;Inherit;False;Property;_DissolveFlowY;DissolveFlow Y;35;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;97;-6176,-1536;Inherit;True;Property;_Main90degreeUVFlip;Main90degree UV Flip;11;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;98;-5792,-1472;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;99;-5760,-1312;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;86;-5504,-768;Inherit;False;Property;_MainFlowX;MainFlow X;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;87;-5520,-672;Inherit;False;Property;_MainFlowY;MainFlow Y;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;127;-5856,-368;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;100;-5616,-1392;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;101;-5632,-1232;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;121;-5456,-80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;175;-5984,192;Inherit;True;Property;_NoiseMask;NoiseMask;44;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;-1648,-1696;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;200;-4448,-720;Inherit;False;Constant;_Float1;Float 1;22;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-4384,112;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;-4112,-48;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;188;-2978,478;Inherit;False;1115.333;514.6667;;8;65;66;60;61;62;64;63;39;Mask;1,0,0.7802367,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;120;-5632,-400;Inherit;False;Property;_MainTexDistortion;MainTex Distortion;39;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;88;-5312,-736;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;89;-5488,-592;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;122;-5488,-224;Inherit;False;Constant;_Float2;Float 2;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;123;-5424,-320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;103;-5440,-1312;Inherit;False;Property;_MainClampY;MainClamp Y;19;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;102;-5440,-1488;Inherit;False;Property;_MainClampX;MainClamp X;18;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;177;-5353.229,219.8307;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;-1472,-1696;Inherit;True;Property;_ColorTex;ColorTex;45;1;[Header];Create;True;1;____Color____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;154;-1184,-1504;Inherit;False;Property;_Desaturate;Desaturate;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;190;-4480,-992;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;191;-4464,-1104;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;192;-4128,-704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;197;-4144,-592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;202;-4384,-1184;Inherit;False;Property;_MainOffsetU;MainOffset U;23;0;Create;True;0;0;0;False;0;False;0.015;0.0059;-0.025;0.025;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;201;-4400,-896;Inherit;False;Property;_MainOffsetV;MainOffset V;28;0;Create;True;0;0;0;False;0;False;0.015;0.0048;-0.025;0.025;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-4464,-192;Inherit;False;0;41;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-4064,32;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;90;-5152,-608;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;104;-5168,-1392;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;126;-5168,-384;Inherit;False;Property;_UseCustom1YDistortion;Use Custom1Y Distortion;38;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;124;-5232,-208;Inherit;False;Property;_UseNoise;Use Noise;37;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-2928,704;Inherit;False;Property;_MaskFlowX;MaskFlow X;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-2928,784;Inherit;False;Property;_MaskFlowY;MaskFlow Y;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;155;-1056,-1664;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;156;-992,-1456;Inherit;False;Property;_ColorPower;ColorPower;50;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;193;-4128,-912;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;194;-4112,-1088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;195;-3888,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;199;-3792,-640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;56;-3904,-64;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;91;-5024,-800;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;125;-4944,-80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;180;-2992,-144;Inherit;False;Property;_OpacityPower;OpacityPower;9;0;Create;True;0;0;0;False;0;False;1;0;0;55;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-2720,720;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-2912,880;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;196;-3904,-1040;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;198;-3584,-800;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;157;-816,-1632;Inherit;False;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;29;-3776,224;Inherit;False;0;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-3744,-96;Inherit;True;Property;_DissolveTex;DissolveTex;29;1;[Header];Create;True;1;_____Dissolve_____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;25;-3808,160;Inherit;False;Property;_ManualDissolve;ManualDissolve;32;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;45;-2864,-256;Inherit;False;Property;_MainRIsAlpha;Main R Is Alpha;14;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;158;-1008,-1344;Inherit;False;Property;_ColorIntensity;Color Intensity;49;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-4064,-512;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;179;-2656,-112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-2576,784;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-2864,544;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;159;-608,-1632;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;204;-3088,-576;Inherit;True;Property;_MainTex2;MainTex;7;1;[Header];Create;True;1;_____Main_____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;43;-3296,-64;Inherit;False;Property;_MainTexRDissolve;MainTex R Dissolve;30;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;178;-3520,224;Inherit;False;Property;_UseManual_DebugDissolve;UseManual_DebugDissolve;31;0;Create;True;0;0;0;False;0;False;1;True;Create;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;24;-3520,96;Inherit;False;Property;_SmoothDissolve;SmoothDissolve;33;0;Create;True;0;0;0;False;0;False;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;203;-3104,-768;Inherit;True;Property;_MainTex1;MainTex;7;1;[Header];Create;True;1;_____Main_____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;169;-2480,-880;Inherit;False;Property;_StylizeShape;StylizeShape;10;0;Create;True;0;0;0;False;0;False;0.01;0.18;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-3136,-976;Inherit;True;Property;_MainTex;MainTex;7;1;[Header];Create;True;1;_____Main_____;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;23;-2736,80;Inherit;True;Dissolve;24;;2;47af3bb98e410a1449d650995124f9e4;0;3;7;FLOAT;0;False;10;FLOAT;0;False;11;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;63;-2400,704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;160;-336,-1728;Inherit;False;Constant;_Float4;Float 3;40;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;161;-320,-1616;Inherit;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;168;-2176,-800;Inherit;True;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;205;-2768,-608;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;181;-2496,-176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-2176,528;Inherit;True;Property;_MaskTex;MaskTex;20;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;162;-80,-1648;Inherit;False;Property;_UseColor;Use Color;46;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DesaturateOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;171;-1936,-656;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;206;-2592,-688;Inherit;False;Property;_MainRBGOffset;MainRBGOffset;15;0;Create;True;0;0;0;False;0;False;1;True;Create;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;28;-2288,0;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-896,320;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-1920,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;14;-1232,256;Inherit;False;Property;_OpacityStrength;OpacityStrength;1;0;Create;True;0;0;0;False;0;False;1;0;0;6;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;170;-1648,-384;Inherit;False;Property;_StylizeMainShape;StylizeMainShape;8;0;Create;True;0;0;0;False;0;False;0;True;Create;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;18;-1472,-224;Inherit;False;Property;_TextureIntensity;TextureIntensity;2;0;Create;True;0;0;0;False;0;False;1;0;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;209;-416,624;Inherit;False;Property;_CameraDepthFadeOffset;CameraDepthFadeOffset;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;-912,480;Inherit;False;Property;_FadeDistance;FadeDistance;3;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;208;-432,544;Inherit;False;Property;_CameraDepthFade;CameraDepthFade;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;165;220.7279,-1624.684;Inherit;False;ColorMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;15;-880,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;33;-592,368;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;207;-256,496;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;166;-992,-64;Inherit;False;165;ColorMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;17;-1024,-432;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-1136,-656;Inherit;False;Property;_MainColor;MainColor;0;2;[HDR];[Header];Create;True;1;_____Base_____;0;0;False;0;False;1,1,1,0;1,1,1,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;20;-784,16;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;22;-720,208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-304,368;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;210;-24.07007,518.7869;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;212;224,656;Inherit;False;Property;_CameraOffset;CameraOffset;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;213;208,304;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;214;176,480;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;19;-736,-176;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;21;-496,-16;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-48,192;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;211;480,496;Inherit;False;float3 viewDirection = cameraWorldPos - vertexWorldPos@$float3 normalizedViewDirection = normalize(viewDirection + 1e-6f)@$float3 worldOffset = normalizedViewDirection * offsetAmount@$return worldOffset@$$$;3;Create;3;True;vertexWorldPos;FLOAT3;0,0,0;In;;Inherit;False;True;cameraWorldPos;FLOAT3;0,0,0;In;;Inherit;False;True;offsetAmount;FLOAT;0;In;;Inherit;False;CameraOffset;True;False;0;;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;6;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;True;2;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=Universal2D;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;SceneSelectionPass;0;6;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ScenePickingPass;0;7;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormals;0;8;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=DepthNormalsOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthNormalsOnly;0;9;DepthNormalsOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=DepthNormalsOnly;False;True;11;d3d11;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;switch2;webgpu;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;215;448,20;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;MotionVectors;0;10;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;216;448,30;Float;False;False;-1;3;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;XRMotionVectors;0;11;XRMotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;True;1;False;;255;False;;1;False;;7;False;;3;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;1;LightMode=XRMotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;217;448,40;Float;False;False;-1;3;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;GBuffer;0;12;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Unlit;True;5;True;14;all;0;False;True;2;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=UniversalGBuffer;False;True;12;d3d11;gles;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;switch2;webgpu;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;608,-16;Float;False;True;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;19;Curl/Basic/FX/BlendAlpha;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;10;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;5;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;UniversalMaterialType=Unlit;AlwaysRenderMotionVectors=false;True;5;True;14;all;0;False;True;2;5;False;;10;False;;1;1;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;False;True;1;LightMode=UniversalForwardOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;30;Surface;1;638569347965466500;  Keep Alpha;0;0;  Blend;0;638570050359644201;Two Sided;1;0;Alpha Clipping;0;638842681438716692;  Use Shadow Threshold;0;0;Forward Only;0;0;Cast Shadows;0;638569347981399346;Receive Shadows;0;638569349202438441;Receive SSAO;1;0;Motion Vectors;1;0;  Add Precomputed Velocity;0;0;  XR Motion Vectors;0;0;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position;1;0;0;13;False;True;False;True;False;False;True;True;True;False;True;False;True;False;;False;0
WireConnection;109;0;107;0
WireConnection;109;1;108;0
WireConnection;130;0;143;2
WireConnection;131;0;143;1
WireConnection;111;0;109;0
WireConnection;111;1;110;0
WireConnection;132;0;130;0
WireConnection;132;1;131;0
WireConnection;113;0;112;0
WireConnection;113;1;111;0
WireConnection;134;0;143;0
WireConnection;134;1;132;0
WireConnection;182;0;105;0
WireConnection;182;1;185;0
WireConnection;183;0;182;0
WireConnection;183;1;184;0
WireConnection;94;0;186;0
WireConnection;95;0;186;0
WireConnection;114;1;113;0
WireConnection;135;0;134;0
WireConnection;136;0;134;0
WireConnection;138;0;135;0
WireConnection;139;0;136;0
WireConnection;115;0;114;0
WireConnection;115;1;114;4
WireConnection;140;0;136;0
WireConnection;140;1;139;0
WireConnection;141;0;135;0
WireConnection;141;1;138;0
WireConnection;148;0;144;0
WireConnection;148;1;145;0
WireConnection;96;0;94;0
WireConnection;96;1;95;0
WireConnection;186;0;105;0
WireConnection;186;1;183;0
WireConnection;118;0;115;0
WireConnection;119;0;116;0
WireConnection;119;1;117;0
WireConnection;142;0;140;0
WireConnection;142;1;141;0
WireConnection;151;0;148;0
WireConnection;151;1;149;0
WireConnection;97;0;186;0
WireConnection;97;1;96;0
WireConnection;98;0;97;0
WireConnection;99;0;97;0
WireConnection;100;0;98;0
WireConnection;101;0;99;0
WireConnection;121;0;118;0
WireConnection;121;1;119;0
WireConnection;175;1;176;0
WireConnection;152;0;142;0
WireConnection;152;1;151;0
WireConnection;53;0;58;0
WireConnection;53;1;59;0
WireConnection;88;0;86;0
WireConnection;88;1;87;0
WireConnection;123;0;120;0
WireConnection;123;1;127;4
WireConnection;103;0;99;0
WireConnection;103;1;101;0
WireConnection;102;0;98;0
WireConnection;102;1;100;0
WireConnection;177;0;121;0
WireConnection;177;1;175;1
WireConnection;153;1;152;0
WireConnection;190;0;52;0
WireConnection;191;0;52;0
WireConnection;192;0;202;0
WireConnection;192;1;200;0
WireConnection;197;0;201;0
WireConnection;197;1;200;0
WireConnection;55;0;53;0
WireConnection;55;1;54;0
WireConnection;90;0;88;0
WireConnection;90;1;89;0
WireConnection;104;0;102;0
WireConnection;104;1;103;0
WireConnection;126;1;120;0
WireConnection;126;0;123;0
WireConnection;124;1;122;0
WireConnection;124;0;177;0
WireConnection;155;0;153;0
WireConnection;155;1;154;0
WireConnection;193;0;190;0
WireConnection;193;1;201;0
WireConnection;194;0;202;0
WireConnection;194;1;191;0
WireConnection;195;0;191;0
WireConnection;195;1;192;0
WireConnection;199;0;190;0
WireConnection;199;1;197;0
WireConnection;56;0;57;0
WireConnection;56;1;55;0
WireConnection;91;0;104;0
WireConnection;91;1;90;0
WireConnection;125;0;126;0
WireConnection;125;1;124;0
WireConnection;60;0;65;0
WireConnection;60;1;66;0
WireConnection;196;0;194;0
WireConnection;196;1;193;0
WireConnection;198;0;195;0
WireConnection;198;1;199;0
WireConnection;157;0;155;0
WireConnection;157;1;156;0
WireConnection;41;1;56;0
WireConnection;45;0;10;4
WireConnection;45;1;10;1
WireConnection;52;0;91;0
WireConnection;52;1;125;0
WireConnection;179;0;45;0
WireConnection;179;1;180;0
WireConnection;62;0;60;0
WireConnection;62;1;61;0
WireConnection;159;0;157;0
WireConnection;159;1;158;0
WireConnection;204;1;198;0
WireConnection;43;0;41;1
WireConnection;43;1;10;1
WireConnection;178;0;29;3
WireConnection;178;1;25;0
WireConnection;203;1;196;0
WireConnection;10;1;52;0
WireConnection;23;7;43;0
WireConnection;23;10;24;0
WireConnection;23;11;178;0
WireConnection;63;0;64;0
WireConnection;63;1;62;0
WireConnection;161;0;159;0
WireConnection;168;0;169;0
WireConnection;168;1;206;0
WireConnection;205;0;10;1
WireConnection;205;1;203;2
WireConnection;205;2;204;3
WireConnection;205;3;204;4
WireConnection;181;0;179;0
WireConnection;39;1;63;0
WireConnection;162;1;160;0
WireConnection;162;0;161;0
WireConnection;171;0;168;0
WireConnection;206;0;10;5
WireConnection;206;1;205;0
WireConnection;28;0;181;0
WireConnection;28;1;23;0
WireConnection;38;0;28;0
WireConnection;38;1;39;1
WireConnection;170;0;206;0
WireConnection;170;1;171;0
WireConnection;165;0;162;0
WireConnection;15;0;38;0
WireConnection;15;1;14;0
WireConnection;33;1;44;0
WireConnection;33;0;34;0
WireConnection;207;2;44;0
WireConnection;207;0;208;0
WireConnection;207;1;209;0
WireConnection;17;0;170;0
WireConnection;17;1;18;0
WireConnection;22;0;20;4
WireConnection;22;1;15;0
WireConnection;36;0;33;0
WireConnection;210;0;207;0
WireConnection;19;0;12;0
WireConnection;19;1;17;0
WireConnection;19;2;166;0
WireConnection;21;0;19;0
WireConnection;21;1;20;0
WireConnection;35;0;22;0
WireConnection;35;1;36;0
WireConnection;35;2;210;0
WireConnection;211;0;213;0
WireConnection;211;1;214;0
WireConnection;211;2;212;0
WireConnection;1;2;21;0
WireConnection;1;3;35;0
WireConnection;1;5;211;0
ASEEND*/
//CHKSM=DA690304193FC5CBFDDC22E37EA209913779572F