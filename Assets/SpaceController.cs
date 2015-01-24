using UnityEngine;
using System.Collections;

public class SpaceController : MonoBehaviour {
	public Shader shader1;
	public Shader shader2;

	// Use this for initialization
	void Start () {
		shader1 = Shader.Find("Fractal/Mandelbrot");
		shader2 = Shader.Find("Fractal/BurningShipe");
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetKeyDown("space"))
		{
			if (renderer.material.shader == shader1)
				renderer.material.shader = shader2;
			else
				renderer.material.shader = shader1;
		}
	}
}
