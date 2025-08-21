Shader"ShaderCourse/shd_basic_color_normal_world_space"
{
    Properties // 入力データ
    {
        _Color ("Color", Color) = (1,1,1,1)
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
            float4 _Color;
            
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
                // float2 uv : TEXCOORD0; 
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                // o.normal = mul((float3x3)unity_ObjectToWorld, v.normals); // manual maxtrix transforms
                // o.normal = mul((float3x3)UNITY_MATRIX_M, v.normals); //  model view matrix
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                return float4( i.normal, 1);
            }
            ENDCG
        }
    }
}
