// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Dragon"
{
	Properties
	{
		_Dragon1_low_lambert1_BaseColor("Dragon1_low_lambert1_BaseColor", 2D) = "white" {}
		_Dragon1_low_lambert1_Normal("Dragon1_low_lambert1_Normal", 2D) = "bump" {}
		_Dragon1_low_lambert1_Roughness("Dragon1_low_lambert1_Roughness", 2D) = "white" {}
		_Float0("Float 0", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Dragon1_low_lambert1_Normal;
		uniform float4 _Dragon1_low_lambert1_Normal_ST;
		uniform sampler2D _Dragon1_low_lambert1_BaseColor;
		uniform float4 _Dragon1_low_lambert1_BaseColor_ST;
		uniform sampler2D _Dragon1_low_lambert1_Roughness;
		uniform float4 _Dragon1_low_lambert1_Roughness_ST;
		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Dragon1_low_lambert1_Normal = i.uv_texcoord * _Dragon1_low_lambert1_Normal_ST.xy + _Dragon1_low_lambert1_Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Dragon1_low_lambert1_Normal, uv_Dragon1_low_lambert1_Normal ) );
			float2 uv_Dragon1_low_lambert1_BaseColor = i.uv_texcoord * _Dragon1_low_lambert1_BaseColor_ST.xy + _Dragon1_low_lambert1_BaseColor_ST.zw;
			o.Albedo = tex2D( _Dragon1_low_lambert1_BaseColor, uv_Dragon1_low_lambert1_BaseColor ).rgb;
			float2 uv_Dragon1_low_lambert1_Roughness = i.uv_texcoord * _Dragon1_low_lambert1_Roughness_ST.xy + _Dragon1_low_lambert1_Roughness_ST.zw;
			float4 tex2DNode4 = tex2D( _Dragon1_low_lambert1_Roughness, uv_Dragon1_low_lambert1_Roughness );
			float4 temp_cast_1 = (_Float0).xxxx;
			o.Smoothness = pow( tex2DNode4 , temp_cast_1 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
137;7;1520;1004;1300.514;632.6552;1.225;True;False
Node;AmplifyShaderEditor.SamplerNode;4;-925.794,182.8956;Inherit;True;Property;_Dragon1_low_lambert1_Roughness;Dragon1_low_lambert1_Roughness;3;0;Create;True;0;0;False;0;09e68383187a235469a22da1b54a02f7;09e68383187a235469a22da1b54a02f7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-409.9391,264.0447;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;8;-563.3568,180.615;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-804.4915,423.7215;Inherit;True;Property;_Dragon1_low_lambert1_Height;Dragon1_low_lambert1_Height;1;0;Create;True;0;0;False;0;a8f6b598f9a6dbe46bb333302d4353d7;a8f6b598f9a6dbe46bb333302d4353d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-809.8805,-30.13685;Inherit;True;Property;_Dragon1_low_lambert1_Normal;Dragon1_low_lambert1_Normal;2;0;Create;True;0;0;False;0;9d7a885b8a59f4a4899f9a6b5cea875c;9d7a885b8a59f4a4899f9a6b5cea875c;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-818.3604,-266.8112;Inherit;True;Property;_Dragon1_low_lambert1_BaseColor;Dragon1_low_lambert1_BaseColor;0;0;Create;True;0;0;False;0;77dfe37456d36904baae7cf78c2e5204;77dfe37456d36904baae7cf78c2e5204;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;9;-296.8891,171.4449;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Dragon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;4;0
WireConnection;9;0;4;0
WireConnection;9;1;10;0
WireConnection;0;0;1;0
WireConnection;0;1;3;0
WireConnection;0;4;9;0
ASEEND*/
//CHKSM=456DD78371B2BF8522C3D90035F28276B0DEB933