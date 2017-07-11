Shader "Custom/NormalMap" {  
    Properties {  
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  
        _NormalMap ("Normal Map", 2D) = "white" {}  
    }  
    SubShader {  
        Tags { "RenderType"="Opaque"}  
        LOD 200  
          
        CGPROGRAM  
        #pragma surface surf Lambert  
  
        sampler2D _MainTex;  
        sampler2D _NormalMap;  
  
        struct Input {  
            float2 uv_MainTex;  
            half2 uv_NormalMap;  
        };  
  
		void surf (Input IN, inout SurfaceOutput o) {  
		    fixed4 c = tex2D (_MainTex, IN.uv_MainTex);  
		    o.Albedo = c.rgb;  
		    o.Alpha = c.a;  
		    fixed3 n = UnpackNormal(tex2D (_NormalMap, IN.uv_NormalMap));  
		    o.Normal = n;  
		}   
  
        ENDCG  
    }  
    FallBack "Diffuse"  
}  