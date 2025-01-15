Shader "Unlit/shd_basic_color"
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
                return _Color;
            }
            ENDCG
        }
    }
}
