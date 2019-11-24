using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManagement : MonoBehaviour
{
    [SerializeField] private float _timeGame = 120;
    [SerializeField] private GameObject text;

    void Update()
    {
        _timeGame -= Time.deltaTime;

        if (_timeGame <= 0)
        {
            EndGame();
        }
    }

    private void EndGame()
    {
        Time.timeScale = 0;
        text.SetActive(true);
    }
}
