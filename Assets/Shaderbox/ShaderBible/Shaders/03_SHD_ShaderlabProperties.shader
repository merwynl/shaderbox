Shader "ShaderBox/Unlit/03_SHD_ShaderlabProperties" {
    Properties
    {

        // Declaring shader properties
        _MainTex ("Texture", 2D) = "white" {}
        _BaseColor("Color", Color) = (1,1,1,1)
        _Specular("Specular", Range(0.0, 1.1)) = 0.3 // name ("display name", Range(min, max)) = defaultValue
        _Factor("Color Factor", Float) = 0.3 // name ("display name", Float) = defaultValue
        _Cid("Color ID", Int) = 2 // name ("display name", Int) = defaultValue
        _Reflection("Reflection", Cube) = "defaultReflectionCube" // Cubemap
        _3DTexture ("3D Texture", 3D) = "defaultColorTexture"
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

            // Add connection variables
            sampler2D _MainText;
            float4 _BaseColor;

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
            float4 _MainTex_ST;

            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            
            fixed4 frag (interpolators i) : SV_Target
            {
                
                // sample the texture
                fixed4 tex = tex2D(_MainTex, i.uv);
                half4 col = float4(1,1,1,1);
                return col;
            }
            ENDCG
        }
    } Fallback "ExampleOtherShader"
}


