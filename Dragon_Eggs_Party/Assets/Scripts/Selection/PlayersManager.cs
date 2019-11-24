using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayersManager : MonoBehaviour
{
    private int _numberOfPlayers = 0;
    private int _acceptCounter = 0;
    [SerializeField] private Dragons _dragonsData;
    private GameObject[] _choices;


    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
    }

    private void Start()
    {
        _choices = new GameObject[4];
    }

    // Update is called once per frame
    void Update()
    {
        if (_acceptCounter >= 1 && _acceptCounter == _numberOfPlayers)
        {
            LoadFinalScene();
        }
    }

    public void LoadFinalScene()
    {
        if (SceneManager.GetActiveScene().name == "Selection")
        {
            SceneManager.LoadScene("Scene_Finale");
        }
    }

    public void AddPlayer()
    {
        _numberOfPlayers++;
    }

    public void AddAccept()
    {
        _acceptCounter++;
    }

    public void ChoicesStorage(int playerID, GameObject skin)
    {
        _choices[playerID] = skin;
    }

    public GameObject GetSkin(int playerID)
    {
        return _choices[playerID];
    }
}
