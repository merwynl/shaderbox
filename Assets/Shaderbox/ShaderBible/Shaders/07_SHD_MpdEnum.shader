Shader "ShaderBox/Unlit/07_SHD_MpdEnum"
{
    Properties
    {
        // Similar to keyword enum. Difference lies in declaring arguments. More than one value/id pass can be declared.
        // [KeywordEnum(valor, id_00, valor, id_01, etc...)] 
        [Enum(Off,0, Front, 1, Back,2)]
        _Face ("Face Culling", Float) = 0
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader
        {
            Tags { "RenderType"="Opaque" }
            
            // Passing the property to a command
            Cull[_Face]
    
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
    
                #include "UnityCG.cginc"
    
                sampler2D _MainTex;
                float4 _Color;
    
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
                return _Color;
            }
                
                ENDCG
            }
        }
    }


