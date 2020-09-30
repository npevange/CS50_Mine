using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;
using UnityEngine.UI;

public class TextUpdate : MonoBehaviour {

	public static string displaytext;
	private Text text;
	// Use this for initialization
	void Start () {
		text = GetComponent<Text>();
		displaytext = "";
	}
	
	// Update is called once per frame
	void Update () {
		text.text = displaytext;
	}
}
