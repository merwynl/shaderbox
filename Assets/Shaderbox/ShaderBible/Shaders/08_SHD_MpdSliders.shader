Shader "ShaderBox/Unlit/07_SHD_MpdSliders"
{
    Properties
    {
        // Sliders for working with numerical range values & precisions
        
        // Power slider - generates a non-linear slider with curve control
        // [PowerSlider(3.0)] _PowerSlider ("PowerSlider", Range(0.01,1)) = 0
        _Brightness ("Brightness", Range(0.0,1)) = 0.08
        
        // IntRange - NUmerical range of integer values
        // [IntRange] _IntRange("Int Range", Range (0,255)) = 100
        _Samples ("Samples", Range(0,255)) = 100
        
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
    
                // Declare preprocessor
                #pragma multi_compile _OPTIONS_OFF _OPTIONS_RED _OPTIONS_BLUE
    
                #include "UnityCG.cginc"
    
                float _Brightness;
                int _Samples;
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
                fixed4 frag (interpolators i) : SV_Target
            {
                // Returns a basic color
                return _Color;
            }
                
                ENDCG
            }
        }
    }


