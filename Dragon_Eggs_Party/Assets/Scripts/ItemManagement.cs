using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemManagement : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private GameObject _item;
    [SerializeField] private bool _hasItem = false;
    [SerializeField] private Transform _hold;

    [SerializeField] private GameObject _pickUp;

    public void PickUp(GameObject item)
    {
        if (!_hasItem)
        {
            _item = item;
            _pickUp = Instantiate (_item, _hold.position, Quaternion.identity);
            _pickUp.transform.parent = this.transform;
            Destroy(item);
            _hasItem = true;
        }
    }

    public void Drop()
    {
        if (_hasItem)
        {
        Instantiate(_pickUp, transform.position, Quaternion.identity);
        Destroy(_pickUp);
        _hasItem = false;
        }
    }


    public void Use()
    {

    }
}
