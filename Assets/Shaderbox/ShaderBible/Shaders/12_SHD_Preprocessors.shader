Shader "ShaderBox/Unlit/12_SHD_Preprocessors"
{
    Properties
    {
        _Color("Color", Color) = (0,0,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            //  Start of CG declaration
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // Make fog work
            #pragma multi_compile_fog

            // Imports several built-in Unity functions
            #include "UnityCG.cginc"
            
            float4 _Color;
            
            struct meshdata
            {
                float4 vertex : POSITION;
                 UNITY_FOG_COORDS(1)
                float2 uv : TEXCOORD0;
            };

            struct interpolators
            {
                float4 vertex : SV_POSITION;
                // float2 uv : TEXCOORD0;
            };

            // Vertex shader - name inherited from preprocessor
            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                UNITY_APPLY_FOG(i.fogCoords,col);
                return o;
            }
            
            // Fragment shader - name inherited from preprocessor
            fixed4 frag (interpolators i) : SV_Target
            {
                // Returns a basic color
                return _Color;
            }
            ENDCG
        }
    }
}

