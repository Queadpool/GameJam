using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Coal : MonoBehaviour
{

    [SerializeField] private bool _coalTook = false;
    [SerializeField] private bool _coalTaken = false;
    [SerializeField] private float _lifeTime = 3.0f;
    public Spawner SpawnerManager;

    void Update()
    {
        if (_coalTook)
        {
            transform.position = SpawnerManager._snapPoint.transform.position;
<<<<<<< HEAD
=======

            if (Input.GetKeyDown(KeyCode.E))
            {
                //if ()
            }
>>>>>>> origin/master
        }
        else if(!_coalTaken)
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
        if (Input.GetKeyDown(KeyCode.E))
        {
            if (other.tag == "Oeuf")
            {
                Debug.Log("Oeuf");
                SpawnerManager.CoalDropToThePoele();
                Destroy(gameObject);
            }
            else if (other.tag == "Dragon")
            {
                if (_coalTook)
                {
                    _coalTook = false;
                }
                else
                {
                    _coalTook = true;
                    _coalTaken = true;
                }
            }
        }
    }
}
