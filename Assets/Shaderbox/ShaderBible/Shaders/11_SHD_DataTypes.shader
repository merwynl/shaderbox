Shader "ShaderBox/Unlit/11_SHD_DataTypes"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
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

            /* Common data type's
             * float - 32-bit high precision. Uses - calculating positions in World-Space, UV, or scalar calculations.
             * float2
             * float3
             * float4
             * half - 16-bit medium-precision - low magnitude vectors, directions, OS positions, hdr colors
             * half2
             * half3
             * half4
             * fixed - 11 bit low precision, and is mainly used in the calculation of simple operations 
             * fixed2
             * fixed3
             * fixed4
             * int
             * sampler2D
             * samplerCube
             * 
             */

            /* Matrices - Denoted by rows & columns

               // 3x3 Matrix
               float 3x3 name = float3x3
               {
                    1,0,0,
                    0,1,0,
                    0,0,1
               };

               // 2x2 Matrix
               half2x2 name = half2x2
               {
                    1,0,
                    0,1
               };    
             
               // 4x4 Matrix
               fixed4x4 name = fixed4x4
               {
                    1,0,0,0,
                    0,1,0,0,
                    0,0,1,0,
                    0,0,0,0
               };  
             */
            
            float4 _Color;

            struct meshdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct interpolators
            {
                float4 vertex : SV_POSITION;
                // float2 uv : TEXCOORD0;
            };

            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }
            fixed4 frag (interpolators i) : SV_Target
            {
                // Returns a basic color
                return _Color;
            }
            
            ENDCG
        }
    }
}

