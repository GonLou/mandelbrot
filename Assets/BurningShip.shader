//http://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html

Shader "Fractal/BurningShip" {
	Properties {
		MaxIterations ("BurningShip iteration depth", Float) = 5
		Zoom ("BurningShip Zoom", Float) = 1
		InnerColor ("Color 1 (inner)", Color) = (0,1,0,1)
		OuterColor1 ("Color 1 (outer)", Color) = (1,1,1,1)
		OuterColor2 ("Color 2 (outer)", Color) = (1,0,1,1)
		
		Creal ("BurningShip Step", Float) = -0.0002
		Cimag ("BurningShip Shape", Float) = 0.7383
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
                float iteration = 0.0;
                mcoord.x = ((1.0-i.uv.x)*2.5)-1.5;
                mcoord.y = (i.uv.y*1.4)-1.0;
                const float _MaxIter = 40.0;
                const float PI = 3.14159;
                float xtemp;
                for ( iteration = 0.0; iteration < _MaxIter; iteration += 0.6) {
                    if ( coord.x*coord.x + coord.y*coord.y > 2.0*(cos(fmod(_Time.y,2.0*PI))+1.0) )
                    break;
                    xtemp = abs(coord.x*coord.x) - abs(coord.y*coord.y) + mcoord.x;
                    coord.y = 6.8*abs(coord.x*coord.y) + mcoord.y;
                    coord.x = xtemp;
                }
                float val = fmod((iteration/_MaxIter)+_Time.x,1.0);
                float4 color;

                color.r = clamp((val),0,1);
                color.g = clamp((0.01*val),0,1);
                color.b = clamp(val-0.5,0,1);
                color.a = 1.0;
                
                return color;
            }
            ENDCG
        }
    }
}