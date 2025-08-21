Shader "ShaderBox/Unlit/09_SHD_MpdSpaceHeaders"
{
    Properties
    {
        // Spaces & headers used for organizational purposes only
        // Add header
        [Header(Base Color)]
        _BaseColor("Color", Color) = (1,1,1,1)
        
        [Space(10)]
        
        [Header(Specular Properties)]
        _Specular("Specular", Range(0.0, 1.1)) = 0.08
        _Brightness("Brightness", Range(0.0, 1.1)) = 0.08
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
        
        [Space(10)]
        
        [Header(Texture Properties)]
        _MainTex("Texture", 2D) = "white"{}
        
    }
    SubShader
        {
            Tags { "RenderType"="Opaque" }
    
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
    
                #include "UnityCG.cginc"
    
                float _Brightness;
                int _Samples;
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
                return _BaseColor;
            }
                
                ENDCG
            }
        }
    }


