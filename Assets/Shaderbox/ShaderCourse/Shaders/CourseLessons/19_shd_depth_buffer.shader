Shader"ShaderCourse/shd_depth_buffer_testing"
{
    Properties // 入力データ
    {
        _Color_A ("Color A", Color) = (1,1,1,1)
        _Color_B ("Color B", Color) = (1,1,1,1)
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
    }
    SubShader
    {
        Tags {
            "RenderType"="Transparent" // Informs the render pipeline of what type of material. Does not change sorting
            "Queue" = "Transparent" // Changes render order - skybox, opaque, transparent, overlay
        }
        
        Pass
        {
            // Culling
            Cull Off // Enable double side
            // Cull Back // Cull back faces
            // Cull Front // Flips face normals
            
            // Depth buffer stuff
            ZWrite Off
            // ZTest LEqual // If the depth <= depth buffer show it, else don't
            // ZTest GEqual // If the depth >= depth buffer show it, else don't
            ZTest Always // Always draws, ignores zbuffer.
            
            // Blending modes
            Blend One One // Additive blend mode
            // Blend DstColor Zero // Multip
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #define TAU 6.28318530718

            #include "UnityCG.cginc"

            // Defining the variables specified in the properties
            float4 _Color_A;
            float4 _Color_B;
            float _ColorStart;
            float _ColorEnd;
            
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
                float2 uv : TEXCOORD1;
            };

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals); // just passing through data
                o.uv =  v.uv0; 
                return o;
            }
            
            float4 frag (Interpolators i) : SV_Target
            {
                // Zigzag wave
                float xOffset = cos(i.uv.x * TAU * 8 ) * 0.01;
                
                // Adding _Time to pattern
                float t = cos((i.uv.y + xOffset - _Time.y * 0.1)* TAU * 5) * 0.5 + 0.5;

                // Multiplies the wave pattern by a vertical gradient
                t *= 1-i.uv.y;

                // Hack to remove top & bottom faces from a mesh. e.g cylinders end caps
                 float capRemover = t * (abs( i.normal.y) < 0.999);

                float waves = t * capRemover;

                float4 gradient = lerp(_Color_A, _Color_B, i.uv.y);
                
                return gradient * waves;
                
            }
            ENDCG
        }
    }
}
