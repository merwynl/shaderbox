Shader "ShaderBox/Unlit/02_SHD_ShaderFunction" // Defines the inspector path
{
    Properties
    {
        // Properties, parameters or inputs
        _MainTex ("Texture", 2D) = "white" {}
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

            // Code block is executed top to bottom
            float4 ourFunction()
            {
                return 0;
            }
            
            fixed4 frag (interpolators i) : SV_Target
            {

                float4 f = ourFunction();
                
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                return f;
            }
            
            ENDCG
        }
    } Fallback "ExampleOtherShader"
}


