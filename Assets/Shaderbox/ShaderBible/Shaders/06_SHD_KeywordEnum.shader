Shader "ShaderBox/Unlit/06_SHD_KeywordEnum"
{
    Properties
    {
        // [KeywordEnum(StateOff, State01,...)] 
        // Keyword Enum
        [KeywordEnum(Off,Red,Blue)]
        _Options ("Color Options", Float) = 0
    }
    SubShader
        {
            Tags { "RenderType"="Opaque" }
    
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
    
                // Declare preprocessors - this is required for generating state conditions
                #pragma multi_compile _OPTIONS_OFF _OPTIONS_RED _OPTIONS_BLUE
    
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
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };
    
                interpolators vert (meshdata v)
                {
                    interpolators o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    return o;
                }
                half4 frag (interpolators i) : SV_Target
                {
                    half4 col = tex2D(_MainTex, i.uv);

                    // Sets condition for different options
                    #if _OPTIONS_OFF
                        return col;
                    #elif _OPTIONS_RED
                        return col * float4(1,0,0,1);
                    #elif _OPTIONS_BLUE
                        return col * float4(0,0,1,1);
                    #endif
                }
                
                ENDCG
            }
        }
    }


