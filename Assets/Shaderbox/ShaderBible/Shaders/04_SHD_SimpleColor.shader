Shader "ShaderBox/Unlit/04_SHD_SimpleColor" {
    Properties
    {
        // Declaring shader properties
        _Color("Color", Color) = (1,1,1,1)
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


