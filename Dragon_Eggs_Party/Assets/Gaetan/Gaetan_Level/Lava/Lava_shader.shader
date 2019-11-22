// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Lava_shader"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Base_color("Base_color", Color) = (0.7075472,0,0,0)
		[HDR]_Emissive_out("Emissive_out", Color) = (2,0.4856046,0,0)
		[HDR]_Emissive_in("Emissive_in", Color) = (2.996078,0.4607151,0,0)
		_Noise_tile("Noise_tile", Float) = 3
		_Deform_min("Deform_min", Float) = 0.75
		_Deform_max("Deform_max", Float) = 1.65
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
		};

		uniform float _Deform_min;
		uniform float _Deform_max;
		uniform float _Noise_tile;
		uniform float4 _Base_color;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float4 _Emissive_in;
		uniform float4 _Emissive_out;
		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float2 voronoihash1( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi1( float2 v, inout float2 id )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash1( n + g );
					o = ( sin( ( _Time.y / 2.0 ) + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 panner270 = ( ( _Time.y / 10.0 ) * float2( -1,-1 ) + (ase_worldPos).xz);
			float simplePerlin2D196 = snoise( (float2( 0,0 )*_Noise_tile + panner270)*0.75 );
			simplePerlin2D196 = simplePerlin2D196*0.5 + 0.5;
			float temp_output_200_0 = pow( simplePerlin2D196 , 0.03 );
			float smoothstepResult243 = smoothstep( _Deform_min , _Deform_max , temp_output_200_0);
			float3 temp_cast_0 = (smoothstepResult243).xxx;
			v.vertex.xyz += temp_cast_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_140_0 = (ase_worldPos).xz;
			float2 panner270 = ( ( _Time.y / 10.0 ) * float2( -1,-1 ) + (ase_worldPos).xz);
			float simplePerlin2D196 = snoise( (float2( 0,0 )*_Noise_tile + panner270)*0.75 );
			simplePerlin2D196 = simplePerlin2D196*0.5 + 0.5;
			float temp_output_200_0 = pow( simplePerlin2D196 , 0.03 );
			float2 lerpResult209 = lerp( (temp_output_140_0*0.5 + ( _Time.y / 20.03 )) , (temp_output_140_0*0.5 + _Time.x) , temp_output_200_0);
			float2 coords1 = lerpResult209 * 5.0;
			float2 id1 = 0;
			float voroi1 = voronoi1( coords1, id1 );
			float2 temp_cast_0 = (voroi1).xx;
			float simplePerlin2D192 = snoise( temp_cast_0 );
			simplePerlin2D192 = simplePerlin2D192*0.5 + 0.5;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth181 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth181 = abs( ( screenDepth181 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 0.6 ) );
			float clampResult190 = clamp( ( ( 1.0 - distanceDepth181 ) * 0.45 ) , 0.0 , 0.7 );
			float temp_output_189_0 = ( voroi1 + ( pow( simplePerlin2D192 , 0.15 ) * clampResult190 ) );
			o.Albedo = ( _Base_color * ( pow( temp_output_189_0 , 0.8 ) + 0.5 ) ).rgb;
			float temp_output_10_0 = pow( temp_output_189_0 , 2.0 );
			float smoothstepResult97 = smoothstep( 0.02 , 0.25 , temp_output_10_0);
			float smoothstepResult24 = smoothstep( 0.0 , 0.5 , temp_output_10_0);
			o.Emission = ( ( smoothstepResult97 * _Emissive_in ) + pow( ( ( smoothstepResult24 + 0.05 ) * _Emissive_out ) , 1.5 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
787;80;1520;1004;2672.711;957.4048;1.501028;True;False
Node;AmplifyShaderEditor.CommentaryNode;263;-2774.994,427.9828;Inherit;False;1760.496;359.3731;SECONDARY NOISE;8;273;271;270;267;200;196;198;210;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;90;-2576.619,-141.3366;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;271;-2738.848,524.9871;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;273;-2445.863,596.6232;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;210;-2235.765,665.994;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-2018.72,491.621;Inherit;False;Property;_Noise_tile;Noise_tile;8;0;Create;True;0;0;False;0;3;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;261;-2207.034,-578.4341;Inherit;False;1177.891;331.0176;WORLDSPACE TEXTURE;5;140;143;68;136;280;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;270;-2058.214,584.7867;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-1,-1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;136;-2157.034,-511.4474;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;282;-1812.455,367.2342;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;259;-2759.49,859.4177;Inherit;False;1751.387;653.3352;BORDER;10;193;194;190;191;185;192;183;186;181;182;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1543.624,-373.6167;Inherit;False;Constant;_World_scale;World_scale;5;0;Create;True;0;0;False;0;0.5;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;196;-1534.006,483.8416;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.75;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;262;-1720.297,-5.542578;Inherit;False;704.8494;351.6664;BASIC PATTERN;4;1;91;88;92;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;280;-1401.515,-519.5586;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;20.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;140;-1682.569,-488.9118;Inherit;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;200;-1268.862,485.5679;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-1683.297,89.74303;Inherit;False;Constant;_Voronoi_time;Voronoi_time;0;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;276;-1232.681,-578.6364;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;143;-1260.143,-417.8694;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-2681.727,1259.99;Inherit;False;Constant;_Distance;Distance;6;0;Create;True;0;0;False;0;0.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-1554.961,183.4782;Inherit;False;Constant;_Voronoi_scale;Voronoi_scale;0;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;209;-931.719,-384.4341;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;-1487.397,44.45731;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;181;-2412.121,1224.027;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;183;-2137.15,1232.456;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;1;-1280.447,70.12363;Inherit;True;0;0;1;0;1;False;1;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.RangedFloatNode;186;-2127.749,1342.357;Inherit;False;Constant;_power;power;7;0;Create;True;0;0;False;0;0.45;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-1911.265,1363.295;Inherit;False;Constant;_border_max_value;border_max_value;3;0;Create;True;0;0;False;0;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-1908.349,1227.257;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;192;-2074.517,937.5876;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;194;-1769.45,926.9974;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;190;-1675.258,1275.942;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1549.117,1151.629;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;266;-609.8371,-980.6834;Inherit;False;1855.255;887.2815;YELLOW HIGHLIGHT EMISSIVE;10;100;101;97;14;61;24;93;10;102;12;;1,0.6756024,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;189;-784.1393,347.3551;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-45.7374,-930.6834;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;24;-559.8372,-375.3764;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;265;-331.597,-1500.187;Inherit;False;885.9232;457.751;BASE COLOR;4;47;58;15;60;;0.6886792,0.1457914,0.07471521,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-260.5008,-351.4487;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-56.39436,-374.7287;Inherit;False;Property;_Emissive_out;Emissive_out;6;1;[HDR];Create;True;0;0;False;0;2,0.4856046,0,0;2,0.4856046,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;47;-281.597,-1295.436;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;97;259.5475,-916.3502;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.02;False;2;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;207.3396,-355.9843;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;102;290.7303,-676.1033;Inherit;False;Property;_Emissive_in;Emissive_in;7;1;[HDR];Create;True;0;0;False;0;2.996078,0.4607151,0,0;2.996078,0.4607151,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;269;-289.0767,798.2054;Inherit;False;Property;_Deform_min;Deform_min;9;0;Create;True;0;0;False;0;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;3.553495,-1450.187;Inherit;False;Property;_Base_color;Base_color;5;0;Create;True;0;0;False;0;0.7075472,0,0,0;0.7075472,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;613.9263,-690.1685;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;39.72013,-1252.909;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;93;463.2195,-346.4018;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;1.5;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;268;-289.1839,882.6649;Inherit;False;Property;_Deform_max;Deform_max;10;0;Create;True;0;0;False;0;1.65;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;198;-1827.327,489.8061;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;100;1010.417,-560.054;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;319.3261,-1297.702;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;-964.9752,66.77792;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;243;-70.31355,740.0673;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;261.5921,527.1962;Float;False;True;6;ASEMaterialInspector;0;0;Standard;Lava_shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;273;0;271;0
WireConnection;210;0;90;2
WireConnection;270;0;273;0
WireConnection;270;1;210;0
WireConnection;282;1;267;0
WireConnection;282;2;270;0
WireConnection;196;0;282;0
WireConnection;280;0;90;2
WireConnection;140;0;136;0
WireConnection;200;0;196;0
WireConnection;276;0;140;0
WireConnection;276;1;68;0
WireConnection;276;2;280;0
WireConnection;143;0;140;0
WireConnection;143;1;68;0
WireConnection;143;2;90;1
WireConnection;209;0;276;0
WireConnection;209;1;143;0
WireConnection;209;2;200;0
WireConnection;91;0;90;2
WireConnection;91;1;92;0
WireConnection;181;0;182;0
WireConnection;183;0;181;0
WireConnection;1;0;209;0
WireConnection;1;1;91;0
WireConnection;1;2;88;0
WireConnection;185;0;183;0
WireConnection;185;1;186;0
WireConnection;192;0;1;0
WireConnection;194;0;192;0
WireConnection;190;0;185;0
WireConnection;190;2;191;0
WireConnection;193;0;194;0
WireConnection;193;1;190;0
WireConnection;189;0;1;0
WireConnection;189;1;193;0
WireConnection;10;0;189;0
WireConnection;24;0;10;0
WireConnection;61;0;24;0
WireConnection;47;0;189;0
WireConnection;97;0;10;0
WireConnection;12;0;61;0
WireConnection;12;1;14;0
WireConnection;101;0;97;0
WireConnection;101;1;102;0
WireConnection;58;0;47;0
WireConnection;93;0;12;0
WireConnection;198;0;267;0
WireConnection;198;1;270;0
WireConnection;100;0;101;0
WireConnection;100;1;93;0
WireConnection;60;0;15;0
WireConnection;60;1;58;0
WireConnection;274;0;1;0
WireConnection;274;1;200;0
WireConnection;243;0;200;0
WireConnection;243;1;269;0
WireConnection;243;2;268;0
WireConnection;0;0;60;0
WireConnection;0;2;100;0
WireConnection;0;11;243;0
ASEEND*/
//CHKSM=7390E0415EF0A36411CA633FE023183A9EA78450