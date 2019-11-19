using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Egg : MonoBehaviour
{
    [SerializeField] private int _heat = 0;

    // Update is called once per frame
    void Update()
    {
        Debug.Log(_heat);
    }

    public void ModifyHeat (int heatModifier)
    {
        Debug.Log("modifying heat");
        _heat += Mathf.Clamp(heatModifier, 0, 100);
    }
}
