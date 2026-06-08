Shader "VFXLib/EnhancedExplosionShader"
{
    //=============================================================================
    // Thank you for buying and joining the Coloso Class!
    // Enhanced Explosion Shader - A professional VFX solution for your games
    //=============================================================================
    Properties
    {
        [Header(Rendering Options)]
        [Enum(Off,0,Front,1,Back,2)] _CullMode("Cull Mode", Float) = 0
        
        [Header(Base Textures)]
        _MainTex ("Main Texture", 2D) = "white" {}
        _NoiseTex ("Noise Texture", 2D) = "white" {}
        _DissolveMap ("Dissolve Map", 2D) = "white" {}
        
        [Header(Animation Curves)]
        [Enum(Linear,0,Cubic,1,Elastic,2,Bounce,3)] _OffsetCurve ("Offset Animation Curve", Int) = 0
        
        [Header(Vertex Offset Controls)]
        _OffsetAmount ("Offset Amount", Range(0, 10)) = 1
        _OffsetSpeed ("Offset Speed", Range(0, 5)) = 1
        
        [Header(Dissolve Controls)]
        _DissolveSmoothing ("Dissolve Smoothing", Range(0.001, 0.3)) = 0.03
        _EdgeSharpness ("Edge Sharpness", Range(0.001, 0.1)) = 0.01
        _DissolveNoiseAmount ("Dissolve Noise Amount", Range(0, 0.3)) = 0.05
        _DissolveNoiseScale ("Dissolve Noise Scale", Range(0.5, 10)) = 3
        
        [Header(Dissolve Animation)]
        _DissolveFlowSpeed ("Dissolve Flow Speed", Range(0, 2)) = 0.5
        _DissolveFlowStrength ("Dissolve Flow Strength", Range(0, 0.5)) = 0.1
        
        [Header(Fire Effects)]
        [HDR] _FireColor ("Fire Color", Color) = (1, 0.5, 0, 2)
        _FireWidth ("Fire Width", Range(0, 0.5)) = 0.08
        
        [Header(Smoke Effects)]
        [HDR] _SmokeColor ("Smoke Color", Color) = (0.2, 0.2, 0.2, 0.8)
        _SmokeWidth ("Smoke Width", Range(0, 0.5)) = 0.15
        _SmokeOffset ("Smoke Time Offset", Range(0, 1)) = 0.2
        _SmokeNoiseInfluence ("Smoke Noise Influence", Range(0, 1)) = 0.5
        _SmokeIntensity ("Smoke Intensity", Range(0, 1)) = 0.7
        _SmokeDistortion ("Smoke Distortion", Range(0, 2)) = 0.3
        _SmokeDarkEdge ("Smoke Dark Edge", Range(0, 1)) = 0.4
    }
    
    //=============================================================================
    // SHADER PROGRAM
    //=============================================================================
    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
        
        Blend SrcAlpha OneMinusSrcAlpha
        Cull [_CullMode]
        ZWrite Off
        
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_particles
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            
            //---------------------------------------------------------------------
            // DATA STRUCTURES
            //---------------------------------------------------------------------
            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
                float4 custom1 : TEXCOORD1; // CUSTOM1.xy - x: dissolve progress, y: offset progress
            };
            
            struct Varyings
            {
                float2 uv : TEXCOORD0;
                float4 positionCS : SV_POSITION;
                float4 color : COLOR;
                float2 customData : TEXCOORD1; 
                float noiseValue : TEXCOORD2; 
                float2 noiseUV : TEXCOORD3;  
                float3 positionWS : TEXCOORD4; 
                float3 normalWS : TEXCOORD5;   
            };
            
            //---------------------------------------------------------------------
            // TEXTURES AND SHADER PARAMETERS
            //---------------------------------------------------------------------
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            float4 _MainTex_ST;
            
            TEXTURE2D(_NoiseTex);
            SAMPLER(sampler_NoiseTex);
            
            TEXTURE2D(_DissolveMap);
            SAMPLER(sampler_DissolveMap);
            
            int _OffsetCurve;
            float _OffsetAmount;
            float _OffsetSpeed;
            float _DissolveSmoothing;
            float _DissolveNoiseAmount;
            float _DissolveNoiseScale;
            float _DissolveFlowSpeed;
            float _DissolveFlowStrength;
            float4 _FireColor;
            float4 _SmokeColor;
            float _FireWidth;
            float _SmokeWidth;
            float _SmokeOffset;
            float _SmokeNoiseInfluence;
            float _SmokeIntensity;
            float _SmokeDistortion;
            float _SmokeDarkEdge;
            float _EdgeSharpness;
            
            //---------------------------------------------------------------------
            // ANIMATION FUNCTIONS
            //---------------------------------------------------------------------
            float easeOutCubic(float x) {
                return 1 - pow(1 - x, 3);
            }
            
            float easeInOutQuad(float x) {
                return x < 0.5 ? 2 * x * x : 1 - pow(-2 * x + 2, 2) / 2;
            }
            
            float easeOutElastic(float x) {
                float c4 = (2 * 3.14159) / 3;
                return x == 0 ? 0 : x == 1 ? 1 : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
            }
            
            float easeOutBounce(float x) {
                const float n1 = 7.5625;
                const float d1 = 2.75;
                
                if (x < 1 / d1) {
                    return n1 * x * x;
                } else if (x < 2 / d1) {
                    x -= 1.5 / d1;
                    return n1 * x * x + 0.75;
                } else if (x < 2.5 / d1) {
                    x -= 2.25 / d1;
                    return n1 * x * x + 0.9375;
                } else {
                    x -= 2.625 / d1;
                    return n1 * x * x + 0.984375;
                }
            }
            
            float applyEasing(float x, int curveType) {
                switch(curveType) {
                    case 0: return x; // Linear (no easing)
                    case 1: return easeOutCubic(x); // Cubic
                    case 2: return easeOutElastic(x); // Elastic
                    case 3: return easeOutBounce(x); // Bounce
                    default: return x;
                }
            }
            
            float sharpStep(float edge0, float edge1, float x) 
            {
                float t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
                return t * t * t * (t * (t * 6 - 15) + 10);
            }
            
            //---------------------------------------------------------------------
            // VERTEX SHADER
            //---------------------------------------------------------------------
            Varyings vert(Attributes input)
            {
                Varyings output = (Varyings)0;
                
                float dissolveProgress = input.custom1.x;
                float offsetProgress = input.custom1.y;
                
                float easedOffsetProgress = applyEasing(offsetProgress, _OffsetCurve);
                
                float2 noiseUV = input.uv;
                noiseUV += float2(_Time.y * 0.1, _Time.y * 0.08);
                
                float noise = SAMPLE_TEXTURE2D_LOD(_NoiseTex, sampler_NoiseTex, noiseUV, 0).r;
                
                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
                
                float3 offsetPosition = input.positionOS.xyz + input.normalOS * noise * easedOffsetProgress * _OffsetAmount;
                
                output.positionCS = TransformObjectToHClip(offsetPosition);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color;
                output.customData = float2(dissolveProgress, offsetProgress);
                output.noiseValue = noise;
                output.noiseUV = noiseUV;
                output.positionWS = positionWS;
                output.normalWS = normalWS;
                
                return output;
            }
            
            //---------------------------------------------------------------------
            // FRAGMENT SHADER
            //---------------------------------------------------------------------
            half4 frag(Varyings input) : SV_Target
            {
                half4 baseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv) * input.color;
                
                float2 dissolveNoiseUV = input.uv * _DissolveNoiseScale;
                float dissolveNoise = SAMPLE_TEXTURE2D(_NoiseTex, sampler_NoiseTex, dissolveNoiseUV).r;
                
                float2 flowVector = float2(
                    sin(_Time.y * _DissolveFlowSpeed + input.positionWS.x * 0.1),
                    cos(_Time.y * _DissolveFlowSpeed + input.positionWS.z * 0.1)
                ) * _DissolveFlowStrength;
                
                float2 dissolveUV = input.uv + flowVector;
                
                float dissolveValue = SAMPLE_TEXTURE2D(_DissolveMap, sampler_DissolveMap, dissolveUV).r;
                
                dissolveValue = lerp(dissolveValue, dissolveNoise, _DissolveNoiseAmount);
                
                float2 smokeUV = input.uv + float2(input.noiseValue * _SmokeDistortion - _SmokeDistortion * 0.5, 
                                                input.noiseValue * _SmokeDistortion - _SmokeDistortion * 0.5);
                float smokeNoise = SAMPLE_TEXTURE2D(_NoiseTex, sampler_NoiseTex, smokeUV).r;
                
                float dissolveProgress = input.customData.x;
                float offsetProgress = input.customData.y;
                
                //---------------------------------------------------------------------
                // FIRE AND SMOKE EFFECTS
                //---------------------------------------------------------------------
                float fireDissolveThreshold = dissolveProgress;
                float smokeDissolveThreshold = dissolveProgress - _SmokeOffset;
                
                float edgeSmoothness = _EdgeSharpness;
                
                float fireEdge = sharpStep(fireDissolveThreshold - _DissolveSmoothing, 
                                          fireDissolveThreshold + _DissolveSmoothing, 
                                          dissolveValue);
                
                float fireMask = sharpStep(fireDissolveThreshold - _FireWidth - edgeSmoothness, 
                                          fireDissolveThreshold, 
                                          dissolveValue);
                
                float boundaryMask = step(fireDissolveThreshold - _FireWidth - edgeSmoothness * 2, dissolveValue);
                
                float smokeMask = sharpStep(smokeDissolveThreshold - _SmokeWidth - edgeSmoothness - smokeNoise * _SmokeNoiseInfluence, 
                                           smokeDissolveThreshold, 
                                           dissolveValue) * 
                                 (1.0 - boundaryMask);
                
                float smokeEdge = sharpStep(0.0, _SmokeDarkEdge, 
                                          1.0 - abs(dissolveValue - (smokeDissolveThreshold - _SmokeWidth * 0.5)));
                
                float4 enhancedSmokeColor = _SmokeColor;
                enhancedSmokeColor.rgb *= (1.0 - smokeEdge * _SmokeDarkEdge);
                enhancedSmokeColor.rgb = lerp(enhancedSmokeColor.rgb, enhancedSmokeColor.rgb * smokeNoise, _SmokeNoiseInfluence);
                
                half4 finalColor = baseColor;
                
                finalColor.rgb = lerp(finalColor.rgb, enhancedSmokeColor.rgb, smokeMask * _SmokeIntensity);
                
                finalColor.rgb = lerp(finalColor.rgb, _FireColor.rgb, fireMask);
                
                finalColor.a *= max(fireEdge, smokeMask);
                
                clip(finalColor.a - 0.001);
                
                return finalColor;
            }
            ENDHLSL
        }
    }
    CustomEditor "ExplosionShaderGUI"
}