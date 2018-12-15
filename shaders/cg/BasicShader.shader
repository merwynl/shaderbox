//////////////////////////////////////////////////////
// Refer to https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
// Lighting model examples include Lambertian, DisneyBRDF, CookTorrance, BlinnPhong.

/////////////////////////////////////////////////////

// A name as well as where the place the shader
Shader "Shaders/Basic"{
	// First specify the properties or parameters you want to create
	Properties{
		// The name of the node followed by the title and type of property
		_myColor ("Example Color", Color) = (1,1,1,1)
		_myNormal ("Normal", Color) = (1,1,1,1)
		_myEmission("Emission Intensity", Float) = 0.0
		_myEmissionColor("Emission Color", Color) = (0,0,0,0)
	}

	// Behaviours of each shader property is done within the SubShader
	SubShader{
		CGPROGRAM
			// Compiler directive containing the type of shader, the name of the function containing
			// said surface shader followed by the lighting model
			#pragma surface surf Lambert

			// Declares input data required by the function. This can include uv, vert & normals)
			struct Input{
				float2 uvMainTex;
			};

			// Associate the properties with a data type. Required for the property to work.
			fixed4 _myColor;
			fixed4 _myNormal;
			fixed4 _myEmissionColor;
			float _myEmission;
			
			// The actual function including the procceses of that function. 
			// Takes in the declared struct data as well as a struc specifying the type of output data to be expected.
			// Output struct changes depending on lighting model being used.
			
			void surf (Input IN, inout SurfaceOutput o){
				// Sets the Albedo to the defined property
				o.Albedo = _myColor.rgb;
				o.Emission = _myEmission * _myEmissionColor.r;
				o.Normal = _myNormal.rgb;
			}
		ENDCG
	}
	// For inferior & outdated GPU's
	FallBack "Diffuse"
}