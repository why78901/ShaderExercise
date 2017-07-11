Shader "Custom/Reflection/Normal" {  
    Properties {  
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  
        _MainTint ("Main Tint", Color) = (1,1,1,1)  
        _CubeMap ("CubeMap", CUBE) = "" {}  
        _ReflAmount ("Reflection Amount", Range(0.01, 1)) = 0.5  
        _NormalMap ("Normal Map", 2D) = "bump" {}  
    }  
    SubShader {  
        Tags { "RenderType"="Opaque"}  
        LOD 200  
          
        CGPROGRAM  
        #pragma surface surf Lambert  
  
        sampler2D _MainTex; 
        sampler2D _NormalMap;   
        fixed4 _MainTint;  
        samplerCUBE _CubeMap;  
        fixed _ReflAmount;  
  
        struct Input {  
		    float2 uv_MainTex;  
		    float2 uv_NormalMap;  
		    float3 worldRefl;  
		    INTERNAL_DATA  
		};  
  
        void surf (Input IN, inout SurfaceOutput o) {  
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;  
		    fixed3 n = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap)).rgb;  
		    o.Normal = n;  
//            o.Emission = texCUBE(_CubeMap, IN.worldRefl).rgb * _ReflAmount;  
		    o.Emission = texCUBE(_CubeMap, WorldReflectionVector(IN, o.Normal)).rgb * _ReflAmount;  
            o.Albedo = c.rgb;  
            o.Alpha = c.a;  
        }  
  
        ENDCG  
    }  
    FallBack "Diffuse"  
}  