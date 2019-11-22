// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Pulse_3"
{
	Properties
	{
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,0.8653269,0.4198113,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample2;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult188 = (float2(0.0 , _Time.y));
			float2 uv_TexCoord170 = i.uv_texcoord * float2( 1,3 ) + appendResult188;
			float4 tex2DNode151 = tex2D( _TextureSample2, uv_TexCoord170 );
			o.Emission = ( _Color0 * tex2DNode151.b ).rgb;
			float lerpResult172 = lerp( 0.0 , tex2DNode151.b , (0.25 + (saturate( _SinTime.w ) - 0.0) * (0.75 - 0.25) / (1.0 - 0.0)));
			o.Alpha = ( pow( ( 1.0 - i.uv_texcoord.y ) , 2.0 ) * lerpResult172 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
275;163;1520;1004;550.1541;238.4297;1;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;187;-1039.601,205.1399;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;184;-763.4239,492.7317;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;188;-839.2184,155.0284;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;176;-516.2222,467.1281;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;189;-423.8811,-241.3839;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;170;-638.1165,112.3484;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,3;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;190;-172.6402,-222.5342;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;182;-251.5465,452.3864;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.25;False;4;FLOAT;0.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;151;-272.0655,117.5439;Inherit;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;a3b899217d109dd4d8741fa6d48f58f3;a3b899217d109dd4d8741fa6d48f58f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;192;27.70689,-224.6769;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;172;90.23951,332.2881;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;186;284.6839,-122.4034;Inherit;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,0.8653269,0.4198113,0;0.6262445,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;582.7701,30.76418;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;464.0663,376.0857;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;984.1406,207.4033;Float;False;True;2;ASEMaterialInspector;0;0;Unlit;Pulse_3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;4;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;188;1;187;0
WireConnection;176;0;184;4
WireConnection;170;1;188;0
WireConnection;190;0;189;2
WireConnection;182;0;176;0
WireConnection;151;1;170;0
WireConnection;192;0;190;0
WireConnection;172;1;151;3
WireConnection;172;2;182;0
WireConnection;185;0;186;0
WireConnection;185;1;151;3
WireConnection;191;0;192;0
WireConnection;191;1;172;0
WireConnection;0;2;185;0
WireConnection;0;9;191;0
ASEEND*/
//CHKSM=7DAC0DE0B8E39A1DF943C469C3B9828E8373611B