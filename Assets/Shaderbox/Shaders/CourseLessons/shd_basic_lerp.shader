Shader"Unlit/shd_basic_lerp"
{
    Properties // 入力データ
    {
        _Color_A ("Color A", Color) = (1,1,1,1)
        _Color_B ("Color B", Color) = (1,1,1,1)
        _Scale ("UV_Scale", Float) = 1
        _Offset ("UV_Offset", Float) = 0
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

            // Defining the float variable specified in the properties
            float4 _Color_A;
            float4 _Color_B;
            float _Scale;
            float _Offset;
            
            struct meshdata // always per-mesh data
            {
                float4 vertex : POSITION; // vertex position
                float3 normals : NORMAL;
                float2 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip space positions
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
                // float2 tangent : TEXCOORD1;
                // float2 justSomeValues : TEXCOORD2;
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                o.uv = (v.uv0 + _Offset) * _Scale; // pass through
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // blends two colors based on the x coords
                float4 outColor = lerp(_Color_A, _Color_B, i.uv.x);
                return outColor;
            }
            ENDCG
        }
    }
}
