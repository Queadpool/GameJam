// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Test_eruption del"
{
	Properties
	{
		_Float2("Float 2", Float) = 0
		[Toggle(_ERUPT_ON)] _ERUPT("ERUPT", Float) = 0
		_perlin_noise("perlin_noise", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma shader_feature _ERUPT_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _perlin_noise;
		uniform float _Float2;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, 0.0,50.0,50.0);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float mulTime73 = _Time.y * 0.1;
			float2 temp_cast_0 = (mulTime73).xx;
			float2 uv_TexCoord3 = v.texcoord.xy * float2( 0.3,0.3 ) + temp_cast_0;
			float grayscale47 = Luminance(tex2Dlod( _perlin_noise, float4( uv_TexCoord3, 0, 0.0) ).rgb);
			float smoothstepResult81 = smoothstep( 1.0 , 1.0 , grayscale47);
			float smoothstepResult46 = smoothstep( 0.0 , (0.3 + (_SinTime.w - 1.0) * (0.5 - 0.3) / (-1.0 - 1.0)) , grayscale47);
			#ifdef _ERUPT_ON
				float staticSwitch80 = smoothstepResult46;
			#else
				float staticSwitch80 = smoothstepResult81;
			#endif
			float smoothstepResult27 = smoothstep( 0.12 , 0.33 , ( ( ( ( 1.0 - v.texcoord.xy.x ) * 1.44 ) * ( v.texcoord.xy.x * 1.44 ) ) * ( ( v.texcoord.xy.y * 1.44 ) * ( ( 1.0 - v.texcoord.xy.y ) * 1.44 ) ) ));
			float3 temp_cast_2 = (smoothstepResult27).xxx;
			float grayscale36 = Luminance(temp_cast_2);
			float lerpResult25 = lerp( 0.0 , staticSwitch80 , saturate( grayscale36 ));
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( ( lerpResult25 * ase_vertexNormal ) * _Float2 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color40 = IsGammaSpace() ? float4(0.6886792,0.1331879,0.1331879,0) : float4(0.4320358,0.01596666,0.01596666,0);
			o.Albedo = color40.rgb;
			float mulTime73 = _Time.y * 0.1;
			float2 temp_cast_1 = (mulTime73).xx;
			float2 uv_TexCoord3 = i.uv_texcoord * float2( 0.3,0.3 ) + temp_cast_1;
			float grayscale47 = Luminance(tex2D( _perlin_noise, uv_TexCoord3 ).rgb);
			float smoothstepResult81 = smoothstep( 1.0 , 1.0 , grayscale47);
			float smoothstepResult46 = smoothstep( 0.0 , (0.3 + (_SinTime.w - 1.0) * (0.5 - 0.3) / (-1.0 - 1.0)) , grayscale47);
			#ifdef _ERUPT_ON
				float staticSwitch80 = smoothstepResult46;
			#else
				float staticSwitch80 = smoothstepResult81;
			#endif
			float smoothstepResult27 = smoothstep( 0.12 , 0.33 , ( ( ( ( 1.0 - i.uv_texcoord.x ) * 1.44 ) * ( i.uv_texcoord.x * 1.44 ) ) * ( ( i.uv_texcoord.y * 1.44 ) * ( ( 1.0 - i.uv_texcoord.y ) * 1.44 ) ) ));
			float3 temp_cast_3 = (smoothstepResult27).xxx;
			float grayscale36 = Luminance(temp_cast_3);
			float lerpResult25 = lerp( 0.0 , staticSwitch80 , saturate( grayscale36 ));
			float4 color79 = IsGammaSpace() ? float4(3.35849,1.101255,0,0) : float4(14.37199,1.236384,0,0);
			o.Emission = ( lerpResult25 * color79 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
140;7;1520;1004;1269.588;1035.039;1.924772;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-2241.755,333.4458;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;10;-1813.738,528.9103;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1890.746,67.69368;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;1.44;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-1910.776,228.238;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1623.697,158.8719;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1642.51,262.3452;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;73;-2189.729,-90.39964;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1596.821,525.7318;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-1602.196,377.9127;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1355.016,479.5208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1864.453,-155.0938;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.3,0.3;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1246.796,169.2905;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;34;-1780.997,-489.5797;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-999.2507,376.5332;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;-1576.979,-50.78416;Inherit;True;Property;_perlin_noise;perlin_noise;2;0;Create;True;0;0;False;0;4f4b7b3fd8cb8cf419ae00d915455013;4f4b7b3fd8cb8cf419ae00d915455013;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCGrayscale;47;-1196.711,-119.6091;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;38;-1359.934,-500.7315;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;-1;False;3;FLOAT;0.3;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;27;-733.8652,353.4671;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.12;False;2;FLOAT;0.33;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;46;-871.1825,-192.3483;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.34;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;81;-884.4161,-450.0183;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;36;-780.9479,155.8839;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;80;-616.5269,-269.5378;Inherit;False;Property;_ERUPT;ERUPT;1;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;35;-559.2457,148.1725;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;31;-346.032,213.2731;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;25;-385.3495,-102.3986;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;79;25.87292,-655.6027;Inherit;False;Constant;_Color1;Color 0;1;1;[HDR];Create;True;0;0;False;0;3.35849,1.101255,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-32.53198,110.6732;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-18.52811,-20.21403;Inherit;False;Property;_Float2;Float 2;0;0;Create;True;0;0;False;0;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;219.6572,87.89843;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;30;-143.9899,422.1366;Inherit;False;3;0;FLOAT;50;False;1;FLOAT;0;False;2;FLOAT;50;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;386.8658,-577.7347;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;40;-17.58659,-420.4406;Inherit;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.6886792,0.1331879,0.1331879,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;877.6348,-23.47131;Float;False;True;6;ASEMaterialInspector;0;0;Standard;Test_eruption del;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;5;2
WireConnection;17;0;5;1
WireConnection;21;0;17;0
WireConnection;21;1;26;0
WireConnection;22;0;5;1
WireConnection;22;1;26;0
WireConnection;24;0;10;0
WireConnection;24;1;26;0
WireConnection;23;0;5;2
WireConnection;23;1;26;0
WireConnection;9;0;23;0
WireConnection;9;1;24;0
WireConnection;3;1;73;0
WireConnection;7;0;21;0
WireConnection;7;1;22;0
WireConnection;11;0;7;0
WireConnection;11;1;9;0
WireConnection;90;1;3;0
WireConnection;47;0;90;0
WireConnection;38;0;34;4
WireConnection;27;0;11;0
WireConnection;46;0;47;0
WireConnection;46;2;38;0
WireConnection;81;0;47;0
WireConnection;36;0;27;0
WireConnection;80;1;81;0
WireConnection;80;0;46;0
WireConnection;35;0;36;0
WireConnection;25;1;80;0
WireConnection;25;2;35;0
WireConnection;32;0;25;0
WireConnection;32;1;31;0
WireConnection;41;0;32;0
WireConnection;41;1;42;0
WireConnection;76;0;25;0
WireConnection;76;1;79;0
WireConnection;0;0;40;0
WireConnection;0;2;76;0
WireConnection;0;11;41;0
WireConnection;0;14;30;0
ASEEND*/
//CHKSM=F07C2016674211B13C04A4EA1B2DC53031303F36