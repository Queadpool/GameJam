using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rewired;
using UnityEngine.SceneManagement;

<<<<<<< HEAD:Dragon_Eggs_Party/Assets/Scripts/Selection/PlayerSelection.cs

=======
>>>>>>> feature/Intégration:Dragon_Eggs_Party/Assets/Scripts/Selection/Selection.cs
public class PlayerSelection : MonoBehaviour
{
    private GameObject[][] _dragons;

    [SerializeField] private Dragons _dragonsData;
    private GameObject[][] _dragonsList;

    [SerializeField] private GameObject[] _dragons1;
    [SerializeField] private GameObject[] _dragons2;
    [SerializeField] private GameObject[] _dragons3;
    [SerializeField] private GameObject[] _dragons4;

    private GameObject[] _choices;
    private int _choiceCounter = 0;

    [SerializeField] private int _playerID = 0;
    [SerializeField] private Player _player;

    [SerializeField] private int _minModel = 0;
    [SerializeField] private int _maxModel = 3;
    [SerializeField] private int _minColour = 0;
    [SerializeField] private int _maxColour = 0;

    private int _modelCounter = 0;
    private int _colourCounter = 0;

    private bool _accepted = false;

    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
    }

    // Start is called before the first frame update
    void Start()
    {

        _modelCounter = _playerID;
        _dragons = new GameObject[4][];
        _dragonsList = new GameObject[4][];

        _dragons[0] = _dragons1;
        _dragons[1] = _dragons2;
        _dragons[2] = _dragons3;
        _dragons[3] = _dragons4;

        _dragonsList[0] = _dragonsData._dragons1;
        _dragonsList[1] = _dragonsData._dragons2;
        _dragonsList[2] = _dragonsData._dragons3;
        _dragonsList[3] = _dragonsData._dragons4;


        _player = ReInput.players.GetPlayer(_playerID);

        _choices = new GameObject[4];

        //toggle off renderers
        foreach (GameObject go in _dragons1)
        {
            go.SetActive(false);
        }
        foreach (GameObject go in _dragons2)
        {
            go.SetActive(false);
        }
        foreach (GameObject go in _dragons3)
        {
            go.SetActive(false);
        }
        foreach (GameObject go in _dragons4)
        {
            go.SetActive(false);
        }

        _dragons[_modelCounter][_colourCounter].SetActive(true);
    }

    // Update is called once per frame
    void Update()
    {
        if (!_accepted)
        {
            OffToggleRender(_modelCounter, _colourCounter);
        
            if (_player.GetButtonDown("Previous Colour"))
            {
                if (_colourCounter == _minColour)
                {
                    _colourCounter = _maxColour;
                }
                else
                {
                    _colourCounter--;
                }
            }
            else if (_player.GetButtonDown("Next Colour"))
            {
                if (_colourCounter == _maxColour)
                {
                    _colourCounter = _minColour;
                }
                else
                {
                    _colourCounter++;
                }
            }


            if (_player.GetButtonDown("Previous Model"))
            {
                if (_modelCounter == _minModel)
                {
                    _modelCounter = _maxModel;
                }
                else
                {
                    _modelCounter--;
                }
            }
            else if (_player.GetButtonDown("Next Model"))
            {
                if (_modelCounter == _maxModel)
                {
                    _modelCounter = _minModel;
                }
                else
                {
                    _modelCounter++;
                }
            }
            OnToggleRender(_modelCounter, _colourCounter);

            if (_player.GetButtonDown("Accept"))
            {
                ChoiceStorage();
                _accepted = true;
            }
        }

        if (_choiceCounter == 1)
        {
            if (SceneManager.GetActiveScene().name == "Selection")
            {
                SceneManager.LoadScene("Scene Alex");
            }

        }
    }

    private void OffToggleRender(int modelCounter, int colourCounter)
    {
        _dragons[modelCounter][colourCounter].SetActive(false);
    }

    private void OnToggleRender(int modelCounter, int colourCounter)
    {
        _dragons[modelCounter][colourCounter].SetActive(true);
    }

    private void ChoiceStorage()
    {
        _choices[_playerID] = _dragonsList[_modelCounter][_colourCounter];
        _choiceCounter++;
    }

    public GameObject GetSkin(int playerID)
    {
        return _choices[_playerID];
    }
}
