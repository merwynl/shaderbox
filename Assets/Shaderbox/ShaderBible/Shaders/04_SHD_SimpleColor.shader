Shader "ShaderBox/Unlit/04_SHD_SimpleColor"
{
    Properties
    {
        // Declaring shader properties
        _MainTex("Texture", 2D) = "white"{}
        _Color("Color", Color) = (1,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            // CG Start
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // Declaring shader connection variables.
            float4 _Color;
            float4 _MainTex_ST;
            sampler2D _MainTex;

            struct meshdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            
            // HLSL Program
            half4 frag (interpolators i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                return col * _Color; // Multiplies the texture by a color
            }
            
            ENDCG
        }
    }
}


