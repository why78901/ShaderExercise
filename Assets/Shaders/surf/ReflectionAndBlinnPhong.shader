Shader "Custom/Reflection/BlinnPhong" {  
    Properties {  
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  
        _MainTint ("Main Tint", Color) = (1,1,1,1)  
        _CubeMap ("CubeMap", CUBE) = "" {}  
        _ReflAmount ("Reflection Amount", Range(0.01, 1)) = 0.5  
        _RimPower ("Fresnel Falloff", Range(0.1, 3)) = 2  
		_SpecPower ("Specular Power", Range(0, 1)) = 0.2
    }  
    SubShader {  
        Tags { "RenderType"="Opaque"}  
        LOD 200  
          
        CGPROGRAM  
        #pragma surface surf Lambert  

        sampler2D _MainTex;  
        fixed4 _MainTint;  
        samplerCUBE _CubeMap;  
        fixed _ReflAmount;  
        half _RimPower;  
		fixed _SpecPower;  
  
        struct Input {  
            float2 uv_MainTex;  
            float3 worldRefl;  
            float3 viewDir;  
        };  
  
//        void surf (Input IN, inout SurfaceOutput o) {  
//            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;  
//            o.Emission = texCUBE(_CubeMap, IN.worldRefl).rgb * _ReflAmount;  
//            o.Albedo = c.rgb;  
//            o.Alpha = c.a;  
//        }  

		void surf (Input IN, inout SurfaceOutput o) {  
		    fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;  
		  
		    half rim = saturate(dot(o.Normal, normalize(IN.viewDir)));  
		      
		    rim = 1.0 - rim;  
		    rim = pow(rim, _RimPower);  
		  
		    o.Emission = texCUBE(_CubeMap, IN.worldRefl).rgb * _ReflAmount * rim;  
		    o.Specular = _SpecPower;  
		    o.Gloss = 1.0;  
		    o.Albedo = c.rgb;  
		    o.Alpha = c.a;  
		}  
        ENDCG  
    }  
    FallBack "Diffuse"  
}  