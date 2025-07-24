Shader "ShaderBox/Unlit/05_SHD_ToggleDrawers" {
    Properties
    {
        // Declaring shader properties
        _MainTex("Texture", 2D) = "white"{}
        _Color("Color", Color) = (1,1,1,1)
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

                // Setting the condition for the toggle
                #if _ENABLE_ON
                    return col;
                #else
                    return col * _Color;
                #endif
            }
            
            ENDCG
        }
    }
}


