using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemsManagement : MonoBehaviour
{
    private bool _hasItem = false;
    private GameObject _item;

    public void PickUp(GameObject item)
    {
        if (!_hasItem)
        {
            _item = item;
            _hasItem = true;
        }
    }

    public void Drop()
    {
        if (_hasItem)
        {
            Instantiate(_item, transform.position, Quaternion.identity);
            _hasItem = false;
        }
    }

    public void Use(Egg egg)
    {
        if (_hasItem)
        {
            int heat = 50;
            if (_item.tag == "Coal")
            {
                heat = 15; 
            }
            else if (_item.tag == "Ice")
            {
                heat = -15;
            }
            egg.ModifyHeat(heat);
            _hasItem = false;
        }
    }
}
