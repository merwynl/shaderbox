Shader"ShaderCourse/shd_basic_color_normal_world_space_frag"
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
                o.normal = v.normals; // just passing through data
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // Better to do this in the vert shader for optimizaiton purposes
                // Generally, there are always more fragments than verts being processed
                return float4( UnityObjectToWorldNormal(i.normal), 1);  
            }
            ENDCG
        }
    }
}
