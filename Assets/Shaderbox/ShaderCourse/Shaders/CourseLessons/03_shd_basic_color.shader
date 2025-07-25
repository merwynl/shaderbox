Shader "ShaderCourse/shd_basic_color"
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
            
            struct meshdata // always per-vertex mesh data
            {
                // Mesh data usually carries float4. float count is dependant on data type
                // Incoming mesh data from the shader or vertex streams
                // UV coords would often be used for things unrelated to texture mapping
                // UV coords, can be used for almost anything
                float4 vertex : POSITION; // local spadce vertex position
                float3 normals : NORMAL; // local space normal direction
                float3 tangent : TANGENT; //tangent normal direction (xyz) tangent sign(w)
                float4 color : COLOR; // vertex colours
                float2 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
                float2 uv1 : TEXCOORD1; // uv1 coords for lightmapping
                float2 uv2 : TEXCOORD1; // uv2 coords for different alpha mapping
            };

            // For data that gets passed from the vert shader to the frag shader
            // These are channels for which you can pass through any data. Only sole requirement is to have SV_POSITION
            // This will blend across the triangle
            struct Interpolators 
            {
                float4 vertex : SV_POSITION; // clip space position
                float2 uv : TEXCOORD0; //
                // UNITY_FOG_COORDS(1)
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o; // Defines var name for output
                o.vertex = UnityObjectToClipPos(v.vertex); // Converts from local space to clip space
                o.uv = v.uv0; // (v.uv0 + _Offset) * _Scale; // pass through
                return o;
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // Swizzling
                float4 myValue;
                float2 otherValue = myValue.xy;
                float2 otherValue2 = myValue.bg;
                
                // _FloatValue = (1,0,0,1);
                return _Color;
            }
            ENDCG
        }
    }
}
