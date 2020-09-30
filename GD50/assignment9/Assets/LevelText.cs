using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class LevelText : MonoBehaviour {
 	public GameObject player;
	private Text text;
	private int level;
	// Use this for initialization
	void Start () {
		text = GetComponent<Text>();
	}
	
	// Update is called once per frame
	void Update () {
			if (player != null) {
				level = LoadSceneOnInput.Level;
				text.text = "Level:" + level;
			}
		
	}
}
