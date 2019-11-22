using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Egg : MonoBehaviour
{
    [SerializeField] private bool _overheat = false;
    [SerializeField] private float _temp = 10.0f;
    [SerializeField] private float _tempMin = 0.0f;
    [SerializeField] private float _tempMax = 100.0f;
    [SerializeField] private float _multiPalier1 = 50.0f;
    [SerializeField] private float _multiPalier2 = 80.0f;
    [SerializeField] private int _multi = 1;
    [SerializeField] private int _coalValue = 20;
    [SerializeField] private int _iceValue = 20;
    [SerializeField] private float _score = 0.0f;

    [SerializeField] private Renderer meshRenderer;
    [SerializeField] private Material instancedMaterial;
    [SerializeField] private GameObject heatEgg;
    [SerializeField] private GameObject warning;
    [SerializeField] private Image tempBar;

    void Start()
    {
        meshRenderer = GetComponent<Renderer>();
        instancedMaterial = meshRenderer.material;
    }


    void Update()
    {
        CalculTemp();

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

    private void CalculTemp()
    {
        if (_temp == _tempMin)
        {
            instancedMaterial.SetFloat("_Chauffe", 0.0f);
            heatEgg.SetActive(false);
            warning.SetActive(false);
            _multi = 0;
        }
        else if (_temp <= _multiPalier1)
        {
            instancedMaterial.SetFloat("_Chauffe", 0.3f);
            heatEgg.SetActive(false);
            warning.SetActive(false);
            _multi = 1;
        }
        else if (_temp <= _multiPalier2)
        {
            instancedMaterial.SetFloat("_Chauffe", 0.5f);
            heatEgg.SetActive(false);
            warning.SetActive(false);
            _multi = 2;
        }
        else
        {
            instancedMaterial.SetFloat("_Chauffe", 1.0f);
            heatEgg.SetActive(true);
            warning.SetActive(true);
            _multi = 4;
        }

        tempBar.fillAmount = _temp / 100;
    }

    private void CalculScore()
    {
        _score += _multi * Time.deltaTime;
    }

    //private void OnTriggerEnter(Collider other)
    //{
    //    if (other.tag == "Coal")
    //    {
    //        _temp += _coalValue;
    //        Destroy(other.gameObject);
    //    }

    //    if (other.tag == "Ice")
    //    {
    //        _temp -= _iceValue;
    //        Destroy(other.gameObject);
    //    }
    //}

    public void HeatModifier(GameObject item)
    {
        if (item.tag == "Coal")
        {
            _temp += _coalValue;
        }

        if (item.tag == "Ice")
        {
            _temp -= _iceValue;
        }
    }
}
