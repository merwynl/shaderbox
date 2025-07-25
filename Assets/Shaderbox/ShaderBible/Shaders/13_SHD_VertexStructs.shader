Shader "ShaderBox/Unlit/13_SHD_VertexStructs"
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
            

            // Imports several built-in Unity functions
            #include "UnityCG.cginc"
            
            float4 _Color;
            float4 _MainTex_ST;

            /* Two structs comes with a basic unlit shader by default:
             * Appdata - Vertex input or where object properties are stored
             * v2f - Vertex-to-Fragment interpolators, Vertex Output
             */
            struct meshdata
            {
                /* Semantics - Access to some mesh data that can be manipulated
                 * Common semantics -
                 * POSITION[n] - Vertex position stored in Object Space
                 * TEXCOORD[n] - Gives access to UV coordinates
                 * TANGENT[n]  - Tangent normals
                 * NORMAL[n]   - Mesh normals
                 * COLOR[n]    - Vertex colors
                 */
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: NORMAL0;
                float3 tangnet : TANGENT0;
                float3 vColor : COLOR0;
            };
            
            struct interpolators
            {
                float4 vertex : SV_POSITION; //sv - system value
                // float2 uv : TEXCOORD0;
                // float2 tangentWorld : TEXCOORD1;
                // float2 binormalWorld : TEXCOORD2;
                // float2 normalWorld : TEXCOORD3;
                // float2 vertColor : COLOR0;
            };
            
            interpolators vert (meshdata v)
            {
                interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex); // Verts stored in object space transformed into clip space
                // o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag (interpolators i) : SV_Target
            {
                // Returns a basic color
                return _Color;
            }
            
            ENDCG
        }
    } Fallback "ShaderPath"
}

