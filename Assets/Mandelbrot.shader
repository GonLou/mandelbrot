//http://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html
//i created the shader according to unity 3d tutorial

Shader "Fractal/Mandelbrot" {
	Properties {
		MaxIterations ("Mandelbrot iteration depth", Float) = 5
		Zoom ("Mandelbrot Zoom", Float) = 1
//		Center ("mandelbrot Center position (XY)", Vector) = (0.5,0.5,0,0)
		InnerColor ("Color 1 (inner)", Color) = (1,0,0,1)
		OuterColor1 ("Color 1 (outer)", Color) = (0,1,0,1)
		OuterColor2 ("Color 2 (outer)", Color) = (0,0,1,1)
		
		Creal ("Mandelbrot Step", Float) = -0.0002
		Cimag ("Mandelbrot Shape", Float) = 0.7383
	}
	SubShader {
		Pass {
			CGPROGRAM
			//#pragma glsl
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"

      float4 frag(v2f_img i) : COLOR {
                float2 mcoord;
                float2 coord = float2(0.0,0.0);
                mcoord.x = ((1.0-i.uv.x)*3.5)-2.5;
                mcoord.y = (i.uv.y*2.0)-1.0;
                float iteration = 0.0;
                const float _MaxIter = 29.0;
                const float PI = 3.14159;
                float xtemp;
                for ( iteration = 0.0; iteration < _MaxIter; iteration += 1.0) {
                    if ( coord.x*coord.x + coord.y*coord.y > 2.0*(cos(fmod(_Time.y,2.0*PI))+1.0) )
                    break;
                    xtemp = coord.x*coord.x - coord.y*coord.y + mcoord.x;
                    coord.y = 2.0*coord.x*coord.y + mcoord.y;
                    coord.x = xtemp;
                }
                float val = fmod((iteration/_MaxIter)+_Time.x,1.0);
                float4 color;

                color.r = clamp((3.0*abs(fmod(2.0*val,1.0)-0.5)),0.0,1.0);
                color.g = clamp((3.0*abs(fmod(2.0*val+(1.0/3.0),1.0)-0.5)),0.0,1.0);
                color.b = clamp((3.0*abs(fmod(2.0*val-(1.0/3.0),1.0)-0.5)),0.0,1.0);
                color.a = 1.0;
                
                return color;
            }
            ENDCG
        }
    }
}