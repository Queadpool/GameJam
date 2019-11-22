// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Pulse"
{
	Properties
	{
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_REDUCE("REDUCE", Float) = 0.3
		_Mask_size("Mask_size", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		AlphaToMask On
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample1;
		uniform float _REDUCE;
		uniform float _Mask_size;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _Color0.rgb;
			float2 appendResult148 = (float2(i.uv_texcoord.x , pow( i.uv_texcoord.y , _REDUCE )));
			float mulTime12 = _Time.y * 0.5;
			float lerpResult127 = lerp( tex2D( _TextureSample1, (appendResult148*1.0 + mulTime12) ).r , 0.0 , saturate( pow( i.uv_texcoord.y , _Mask_size ) ));
			o.Alpha = ( pow( i.uv_texcoord.y , 0.5 ) * lerpResult127 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
899;61;1520;1004;1220.491;176.36;2.060179;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;146;-2598.784,-424.0456;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;145;-2583.847,-285.8114;Inherit;False;Property;_REDUCE;REDUCE;2;0;Create;True;0;0;False;0;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;144;-2572.196,-634.3459;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;147;-2320,-396.096;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;148;-2146.299,-580.8844;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;12;-2313.71,-100.225;Inherit;False;1;0;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-879.2191,791.4064;Inherit;False;Property;_Mask_size;Mask_size;3;0;Create;True;0;0;False;0;1;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;77;-852.4418,940.6282;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;143;-1926.724,-505.8333;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;109;-492.3538,737.9803;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;156;-200.4547,769.9387;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;141;-1599.304,-516.8806;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;a3b899217d109dd4d8741fa6d48f58f3;a3b899217d109dd4d8741fa6d48f58f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;155;-1981.203,31.54721;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;127;334.0892,586.3325;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;152;-1570.869,-98.34476;Inherit;True;Property;_alpha_ok;alpha_ok;4;0;Create;True;0;0;False;0;a3b899217d109dd4d8741fa6d48f58f3;a3b899217d109dd4d8741fa6d48f58f3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;555.8963,148.5966;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;74;626.0466,-78.97166;Inherit;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;982.8086,282.4839;Float;False;True;2;ASEMaterialInspector;0;0;Unlit;Pulse;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;147;0;146;2
WireConnection;147;1;145;0
WireConnection;148;0;144;1
WireConnection;148;1;147;0
WireConnection;143;0;148;0
WireConnection;143;2;12;0
WireConnection;109;0;77;2
WireConnection;109;1;108;0
WireConnection;156;0;109;0
WireConnection;141;1;143;0
WireConnection;155;0;146;2
WireConnection;127;0;141;1
WireConnection;127;2;156;0
WireConnection;154;0;155;0
WireConnection;154;1;127;0
WireConnection;0;2;74;0
WireConnection;0;9;154;0
ASEEND*/
//CHKSM=7FE481374FC819FB01D57CA2AEEA7703410C6C1C