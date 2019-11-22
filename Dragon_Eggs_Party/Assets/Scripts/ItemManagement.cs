using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemManagement : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private Item _item;
    [SerializeField] private bool _hasItem = false;
    [SerializeField] private Transform _snapPoint;

    [SerializeField] private GameObject _pickUp;
    private GameObject _pickDown;

    public void PickUp(Item item, bool destroyable = true)
    {
        if (!_hasItem)
        {
            _item = item;
            _pickUp = Instantiate (_item.transform.gameObject, _snapPoint.position, Quaternion.identity);
            _pickUp.transform.parent = this.transform;
            if (destroyable)
            {
            Destroy(item.transform.gameObject);
            }
            _pickUp.GetComponent<Item>().IsPickedOn();
            _pickUp.GetComponent<Collider>().enabled = false;
            _hasItem = true;
        }
    }

    public void Drop()
    {
        if (_hasItem)
        {
            _pickDown = Instantiate(_pickUp, transform.position, Quaternion.identity);
            Destroy(_pickUp);
            _pickDown.GetComponent<Item>().IsPickedOff();
            _pickDown.GetComponent<Collider>().enabled = true;
            _hasItem = false;
        }
    }


    public void Use(GameObject egg)
    {
        if (_hasItem)
        {
            Debug.Log("Use");
            _hasItem = false;
            egg.GetComponent<Egg>().HeatModifier(_pickUp);
            Destroy(_pickUp);
        }

    }
}
