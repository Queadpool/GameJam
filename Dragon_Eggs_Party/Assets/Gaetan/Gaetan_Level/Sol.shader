// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Sol"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_test_smoothness("test_smoothness", 2D) = "white" {}
		_uv_sol_test2("uv_sol_test2", 2D) = "white" {}
		_Float0("Float 0", Float) = 1
		_Float1("Float 0", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _uv_sol_test2;
		uniform float4 _uv_sol_test2_ST;
		uniform sampler2D _test_smoothness;
		uniform float4 _test_smoothness_ST;
		uniform float _Float1;
		uniform float _Float0;
		uniform float _Cutoff = 0.5;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_uv_sol_test2 = i.uv_texcoord * _uv_sol_test2_ST.xy + _uv_sol_test2_ST.zw;
			float4 tex2DNode2 = tex2D( _uv_sol_test2, uv_uv_sol_test2 );
			o.Albedo = tex2DNode2.rgb;
			float2 uv_test_smoothness = i.uv_texcoord * _test_smoothness_ST.xy + _test_smoothness_ST.zw;
			float grayscale8 = Luminance(tex2D( _test_smoothness, uv_test_smoothness ).rgb);
			o.Metallic = pow( grayscale8 , _Float1 );
			o.Smoothness = pow( grayscale8 , _Float0 );
			o.Alpha = 1;
			clip( tex2DNode2.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
97;7;1520;1004;1270.712;362.6635;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-941,83.5;Inherit;True;Property;_test_smoothness;test_smoothness;6;0;Create;True;0;0;False;0;24b414c370c4f224c89aacc55c72f455;24b414c370c4f224c89aacc55c72f455;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-575.8784,275.3287;Inherit;False;Property;_Float0;Float 0;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;8;-621.712,20.33649;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-581.1512,110.2508;Inherit;False;Property;_Float1;Float 0;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-555,-251.5;Inherit;True;Property;_uv_sol_test2;uv_sol_test2;7;0;Create;True;0;0;False;0;9a36b3387b32b2e42a10db8fe5e4d4dc;9a36b3387b32b2e42a10db8fe5e4d4dc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;9;-300.712,29.33649;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-310.712,204.3365;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;ASEMaterialInspector;0;0;Standard;Sol;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;5;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;1;0
WireConnection;9;0;8;0
WireConnection;9;1;6;0
WireConnection;10;0;8;0
WireConnection;10;1;5;0
WireConnection;0;0;2;0
WireConnection;0;3;9;0
WireConnection;0;4;10;0
WireConnection;0;10;2;4
ASEEND*/
//CHKSM=CB9F4396F04DD887410A7301C02DC57FFF1F3660