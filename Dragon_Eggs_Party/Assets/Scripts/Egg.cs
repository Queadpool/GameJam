using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Egg : MonoBehaviour
{
    [SerializeField] private bool _overheat = false;
    [SerializeField] private float _temp = 10.0f;
    [SerializeField] private float _tempMin = 0.0f;
    [SerializeField] private float _tempMax = 100.0f;
    [SerializeField] private float _multiPalier1 = 50.0f;
    [SerializeField] private float _multiPalier2 = 80.0f;
    [SerializeField] private int _multi = 1;
    [SerializeField] private float _score = 0.0f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Debug.Log("Score " + _score);
        
        if (!_overheat)
        {
            CalculScore();
            DoCook();
        }
        else
        {
            StopCook();
        }

    }

    private void DoCook()
    {
        if (_temp > _tempMax)
        {
            _overheat = true;
        }
        else if (_temp > _tempMin)
        {
            _temp -= Time.deltaTime;
        }
        else
        {
            _temp = _tempMin;
        }
    }

    private void StopCook()
    {
        if (_temp > _tempMin)
        {
            _temp -= Time.deltaTime;
        }
        else
        {
            _overheat = false;
        }
    }

    private void CalculScore()
    {
        if (_temp == _tempMin)
        {
            _multi = 0;
        }
        else if (_temp <= _multiPalier1)
        {
            _multi = 1;
        }
        else if (_temp <= _multiPalier2)
        {
            _multi = 2;
        }
        else
        {
            _multi = 4;
        }

        _score += _multi * Time.deltaTime;
    }
}
