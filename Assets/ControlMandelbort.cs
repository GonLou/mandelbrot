using UnityEngine;
using System.Collections;

public class ControlMandelbort : MonoBehaviour {

	// Use this for initialization
	

  	public Material controlMat;
	
	public float maxStep = 0.5f, maxShape = 2f;
	private float curStep, curShape;	
	
	public float speed = 0.5f;
	
	void Start() {
		curStep = controlMat.GetFloat("Creal");
		curShape = controlMat.GetFloat("Cimag");
	}
	
	// Update is called once per frame
	void Update () {
		curStep = Mathf.Sin(Time.time * speed) * maxStep;
		curShape = Mathf.Sin(Time.time * speed) * maxShape;
		
		controlMat.SetFloat("Creal", curStep);
		controlMat.SetFloat("Cimag", curShape);
	}
}

	
