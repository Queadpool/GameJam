using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Choices : MonoBehaviour
{
    private int[][,] _choices;
    private int _counter = 0;

    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
    }

    private void Start()
    {
        _choices = new int[4][,];
    }

    public void ChoiceStorage(int playerID, int modelCounter, int colourCounter)
    {
        _choices[playerID] = new int[modelCounter, colourCounter];
        _counter++;
    }

    public int[,] GetSkin(int playerID)
    {
        return _choices[playerID];
    }
}
