using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Item : MonoBehaviour
{
    [SerializeField] private bool _onSpawn = true;
    [SerializeField] private bool _isPicked = false;
    [SerializeField] private float _lifeTime = 5.0f;

    void Update()
    {
        /*if (!_isPicked)
        {
            _lifeTime -= Time.deltaTime;
        }*/

        if (_lifeTime <= 0)
        {
            Destroy(gameObject);
        }
    }
}
