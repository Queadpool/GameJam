// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Gaziniere"
{
	Properties
	{
		_gaziniere("gaziniere", 2D) = "white" {}
		_gaziniereemissive("gaziniere-emissive", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _gaziniere;
		uniform float4 _gaziniere_ST;
		uniform sampler2D _gaziniereemissive;
		uniform float4 _gaziniereemissive_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_gaziniere = i.uv_texcoord * _gaziniere_ST.xy + _gaziniere_ST.zw;
			o.Albedo = tex2D( _gaziniere, uv_gaziniere ).rgb;
			float2 uv_gaziniereemissive = i.uv_texcoord * _gaziniereemissive_ST.xy + _gaziniereemissive_ST.zw;
			o.Emission = ( tex2D( _gaziniereemissive, uv_gaziniereemissive ) * _SinTime.w ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
446;145;1520;1010;1594.417;349.7728;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;2;-991.2556,-118.3987;Inherit;True;Property;_gaziniereemissive;gaziniere-emissive;1;0;Create;True;0;0;False;0;aae738a765c686848a7df8d92150d77f;aae738a765c686848a7df8d92150d77f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinTimeNode;9;-898.918,274.2271;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-757.3555,-369.6986;Inherit;True;Property;_gaziniere;gaziniere;0;0;Create;True;0;0;False;0;52b2257daf1b8f84d970a94e4b28da35;52b2257daf1b8f84d970a94e4b28da35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-461.3556,-7.898668;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-7.252088,62.85142;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Gaziniere;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;2;0
WireConnection;4;1;9;4
WireConnection;0;0;1;0
WireConnection;0;2;4;0
ASEEND*/
//CHKSM=D1B6C5C94A595DE97A57630CF9CA3AB67F1C5709