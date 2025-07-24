Shader "ShaderBox/Unlit/05_SHD_ToggleDrawers" {
    Properties
    {
        // Declaring shader properties
        _Color1("Color A", Color) = (1,0,0,1)
        _Color2("Color B", Color) = (0,0,1,1)
        [Toggle] _Enable ("Enabled", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // Declare preprocessor - Required for enabling shader variants basedon a condition
            #pragma shader_feature _ENABLE_ON

            #include "UnityCG.cginc"

            float4 _Color1;
            float4 _Color2;

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
                half4 col = _Color2;

                // Setting the condition for the toggle
                #if _ENABLE_ON
                    return col;
                #else
                    return col * _Color1;
                #endif
            }
            
            ENDCG
        }
    }
}


