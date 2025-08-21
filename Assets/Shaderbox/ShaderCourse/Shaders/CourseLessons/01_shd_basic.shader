Shader "ShaderCourse/shd_basic"
{
    Properties // 入力データ
    {
        _Value ("FloatValue", Float) = 1.0
    }
    SubShader
    {
        // subshader tags
        
        Tags { "RenderType"="Opaque" }
        
        Pass
        {
            // pass tags
            // Everything outside the CG tags are shaderlabs
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // Defining properties as variables within the code
            float _FloatValue;
            

            struct meshdata // always per-mesh data
            {
                float4 vertex : POSITION; // vertex position
                float3 normals : NORMAL;
                // float3 tangent : TANGENT; //tangent normals
                // float4 color : COLOR; // vertex colours
                float2 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
            };

            struct Interpolators // For data that gets passed from the vert shader to the frag shader
            {
                float4 vertex : SV_POSITION; // clip space positions
                // float2 uv : TEXCOORD0; 
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o; // Defines var name for output
                o.vertex = UnityObjectToClipPos(v.vertex); // Converts from local space to clip space 
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // _FloatValue = (1,0,0,1);
                return float4 (1,0,0,1); //red
            }
            ENDCG
        }
    }
}
