Shader "ShaderBox/Unlit/09_SHD_MpdSpaceHeaders"
{
    Properties
    {
        [Header(Base Color)]
        _BaseColor("Color", Color) = (1,1,1,1)
        
        [Header(Texture Properties)]
        _MainTex("Texture", 2D) = "white"{}
    }
    SubShader // Every program has at least one subshader.
        {
            /* Materials have a RenderQueue that determines the processing order of objects.
            *  Queue values range from 0-5000 
            *
            * Tags { “Queue”=”Background” }  goes from 0 to 1499, default value 1000.
            * Tags { “Queue”=”Geometry” }  goes from 1500 to 2399, default value 2000.
            * Tags { “Queue”=”AlphaTest” }  goes from 2400 to 2699, default value 2450.
            * Tags { “Queue”=”Transparent” }  goes from 2700 to 3599, default value 3000.
            * Tags { “Queue”=”Overlay” } goes from 3600 to 5000, default value 4000.
            * 
            */
            
            /* Will affect all passes. Can be used to overwrite the default behaviour
            * 
            * Opaque - Default
            * Transparent.
            * TransparentCutout.
            * Background.
            * Overlay.
            * TreeOpaque.
            * TreeTransparentCutout.
            * TreeBillboard.
            * Grass.
            * GrassBillboard.
            * 
            */
            Tags { "RenderType"="Opaque" } 
            
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
    
                #include "UnityCG.cginc"
                
                float4 _BaseColor;
    
                struct meshdata
                {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                };
    
                struct interpolators
                {
                    // float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };
    
                interpolators vert (meshdata v)
                {
                    interpolators o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    return o;
                }
                fixed4 frag (interpolators i) : SV_Target
            {
                // Returns a basic color
                return _BaseColor;
            }
                
                ENDCG
            }
        }
    }


