﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rewired;

public class Selection : MonoBehaviour
{
    private GameObject[][] _dragons;

    [SerializeField] private GameObject[] _dragons1;
    [SerializeField] private GameObject[] _dragons2;
    [SerializeField] private GameObject[] _dragons3;
    [SerializeField] private GameObject[] _dragons4;



    [SerializeField] private int _playerID = 0;
    [SerializeField] private Player _player;

    [SerializeField] private Choices _choices;

    [SerializeField] private int _minModel = 0;
    [SerializeField] private int _maxModel = 3;
    [SerializeField] private int _minColour = 0;
    [SerializeField] private int _maxColour = 0;

    private int _modelCounter = 0;
    private int _colourCounter = 0;

    private bool _accepted = false;


    // Start is called before the first frame update
    void Start()
    {
        _modelCounter = _playerID;
        _dragons = new GameObject[4][];

        _dragons[0] = _dragons1;
        _dragons[1] = _dragons2;
        _dragons[2] = _dragons3;
        _dragons[3] = _dragons4;


        _player = ReInput.players.GetPlayer(_playerID);



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
                _choices.ChoiceStorage(_playerID, _modelCounter, _colourCounter);
                _accepted = true;
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
}
