using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManagement : MonoBehaviour
{
    [SerializeField] private float _timeGame = 300;

    // Update is called once per frame
    void Update()
    {
        _timeGame -= Time.deltaTime;

        if (_timeGame <= 0)
        {
            Time.timeScale = 0;
        }
    }
}
