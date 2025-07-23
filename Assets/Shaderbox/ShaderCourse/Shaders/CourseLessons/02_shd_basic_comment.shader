Shader "Unlit/shd_basic_comment"
{
    Properties // 入力データ
    {
       // _MainTex ("Texture", 2D) = "white" {}
        _Value ("FloatValue", Float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // make fog work
            // #pragma multi_compile_fog

            #include "UnityCG.cginc"

            // Defining the float variable specified in the properties
            float _FloatValue;

            // sampler2D _MainTex;
            // float4 _MainTex_ST;

            struct meshdata // always per-mesh data
            {
                // Mesh data usually carries float4. float count is dependant on data type
                // Incoming mesh data from the shader or vertex streams
                // UV coords would often be used for things unrelated to texture mapping
                // UV coords, can be used for almost anything
                float4 vertex : POSITION; // vertex position
                float3 normals : NORMAL;
                float3 tangent : TANGENT; //tangent normals
                float4 color : COLOR; // vertex colours
                float2 uv0 : TEXCOORD0; // uv0 diffuse/normal map textures
                float2 uv1 : TEXCOORD1; // uv1 coords for lightmapping
                float2 uv2 : TEXCOORD1; // uv2 coords for different alpha mapping
            };

            struct Interpolators // For data that gets passed from the vert shader to the frag shader
            {
                float4 vertex : SV_POSITION; // clip space positions
                // float2 uv : TEXCOORD0; //
                // UNITY_FOG_COORDS(1)
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o; // Defines var name for output
                o.vertex = UnityObjectToClipPos(v.vertex); // Converts from local space to clip space 
                // o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                // UNITY_TRANSFER_FOG(o,o.vertex);
                return o; // Returns result from interpolator
            }

            // bool 0 1
            // int
            // float =  (32-bit float)
            // half = (16-bit float)
            // fixed = (lower precision) = -1 to 1
            // half and fixed are useful for optimizing expensive functions.
            
            // float4 > half4 > fixed4
            // float 4x4 -> half4x4 (c#: Matrix4x4)

            fixed4 frag (Interpolators i) : SV_Target
            {
                // sample the texture
                _FloatValue = (1,0,0,1);
                // apply fog
                // UNITY_APPLY_FOG(i.fogCoord, col);
                return _FloatValue;
            }
            ENDCG
        }
    }
}
