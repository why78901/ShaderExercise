Shader "Custom/Frag/GrayScale" {  
    Properties {  
        _MainTex ("Albedo (RGB)", 2D) = "white" {}  
        _Luminosity ("GrayScale Amount", Range(0, 1)) = 1  
    }  
    SubShader {  
        Tags { "RenderType"="Opaque" }  
        LOD 200  
  
        Pass  
        {  
            CGPROGRAM  
            #pragma vertex vert_img  
            #pragma fragment frag  
            #pragma fragmentoption ARB_precision_hint_fastest  
            #include "UnityCG.cginc"  
  
            uniform sampler2D _MainTex;  
            fixed _Luminosity;  
  
            fixed4 frag(v2f_img i) : COLOR  
            {  
                fixed4 renderTex = tex2D(_MainTex, i.uv);  
                half lum = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b;  
                fixed4 finalColor = lerp(renderTex, lum, _Luminosity);  
                return finalColor;  
            }  
            ENDCG  
        }  
    }  
    FallBack "Diffuse"  
}  