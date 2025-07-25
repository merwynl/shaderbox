Shader "ShaderCourse/shd_textured"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

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

            sampler2D _MainTex;
            float4 _MainTex_ST; // optional. Magic variable name for adjusting uv scale offset

            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); // Offsets uv coords
                return o;
            }

            fixed4 frag (interpolators i) : SV_Target
            {
                // tex2D(SamplerSource, where to sample from). 0-1 = normalized coords
                fixed4 col = tex2D(_MainTex, i.uv); 
                return col;
            }
            ENDCG
        }
    }
}
