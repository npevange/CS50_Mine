using System.Collections;
using System.Collections.Generic;
using UnityEngine.SceneManagement;
using UnityEngine;

public class Fall : MonoBehaviour {

	public GameObject characterController;
	public GameObject WhisperSource;

	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		if (characterController.transform.position.y < -4) {
			DestroyObject(WhisperSource);
			SceneManager.LoadScene("GameOver");
		}
	}
}
