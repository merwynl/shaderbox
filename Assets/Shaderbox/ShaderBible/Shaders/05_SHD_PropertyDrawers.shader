Shader"Shaderbox/USB/01_SHD_USB_SimpleColor"
{
    Properties
    {
        // Specular
        [Header(Specular Properties)]
        _Specular ("Specular", Range(0.01, 1.0)) = 0.08
        _Brightness ("Brightness", Range(0.01, 1.0)) = 0.08
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        
        [Space(5)]
        
        // Textures
        [Header(Texture Properties)]
        _MainTex ("Texture",2D) = "white" {}
        
        [Space(5)]
        
        [Header(Toggles)]
        
        // Toggle
        [Toggle] _Enable ("Enable Feature?", Float) = 0
        [KeywordEnum(Off, Red,Blue)] _KeywordEnum ("Color Options ?", Float) = 0
  
//        // Num sliders
//        _Specular ("Specular", Range(0.0, 1.0)) = 0.3
//        _Factor ("Color Factor", Float) = 0.3
//        _ColorID ("Color ID", Int) = 2
//        
//        //Color & vector 
//        _Color ("Color", Color) = (1,1,1,1)
//        _VPos ("Vertex Position", Vector) = (0,0,0,1)
//        
//        // Textures
//        _MainTex ("Texture",2D) = "white" {}``
//        _Reflection ("Reflection",Cube) = "black" {}
//        _3DTexture ("3D Texture",3D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature _ENABLE_ON
            #pragma multi_compile _OPTIONS_OFF _OPTIONS_RED _OPTIONS_BLUE

            #include "UnityCG.cginc"
            
            //Connection variables
            float _Factor;
            int _ColorID;
            sampler2D _MainTex;
            samplerCUBE _Reflection;
            sampler3D _3DTexture;
            float4 _Color;
            vector _VPos;
            
            struct meshdata
            {
                float4 vertex : POSITION;
                float3 normals: NORMAL;
                float2 uv0 : TEXCOORD0;
            };

            struct Interpolators
            {
                float2 uv : TEXCOORD0;
                // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };
            

            Interpolators vert (meshdata v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv0;
                return o;
            }

            half4 frag (Interpolators i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
                // #if _ENABLE_ON
                //     return col;
                // #else
                //      return col * _Color;
                // #endif
                #if _OPTIONS_OFF
                    return col;
                #elif _OPTIONS_RED
                    return col * float4(1,0,0,1);
                #elif _OPTIONS_BLUE
                    return col * float4(0,0,1,1);
                #endif
            }
            ENDCG
        }
    }
}
