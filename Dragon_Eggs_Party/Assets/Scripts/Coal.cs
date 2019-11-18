using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coal : MonoBehaviour
{

    [SerializeField] private bool _coalTaken = false;
    [SerializeField] private float _lifeTime = 3.0f;
    public Spawner SpawnerManager;

    void Update()
    {
        if (_coalTaken)
        {
            transform.position = SpawnerManager._snapPoint.transform.position;

            if (Input.GetKeyDown(KeyCode.E))
            {
                if ()
            }
        }
        else
        {
            _lifeTime -= Time.deltaTime;
            if (_lifeTime < 0.0f)
            {
                Destroy(gameObject);
            }
        }
    }

    private void OnTriggerStay(Collider other)
    {
        if((other.tag == "Dragon" && Input.GetKeyDown(KeyCode.E)))
        {
            _coalTaken = true;
            SpawnerManager.CoalTaken();
        }

        if(other.tag == "Oeuf")
        {

        }
    }
}
