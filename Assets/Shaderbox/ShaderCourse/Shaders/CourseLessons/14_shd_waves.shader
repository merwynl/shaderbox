Shader"Unlit/shd_waves"
{
    Properties // 入力データ
    {
        _Color_A ("Color A", Color) = (1,1,1,1)
        _Color_B ("Color B", Color) = (1,1,1,1)
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
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

            // Defining the variables specified in the properties
            float4 _Color_A;
            float4 _Color_B;
            float _ColorStart;
            float _ColorEnd;
            
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
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                o.uv =  v.uv0; 
                return o;
            }
            
            float4 frag (Interpolators i) : SV_Target
            {
                // Data types in shaders implicit cast from a float to a float4 automatically through swizzling.

                // Triangle wave using absolute value
                // float t = abs(frac(i.uv.x * 5) * 2 - 1);
                
                // Cosine wave
                // float t = cos(i.uv.x * 25);

                // Sine wave
                float t = sin(i.uv.x * 25);
                
                return t;
                
            }
            ENDCG
        }
    }
}
