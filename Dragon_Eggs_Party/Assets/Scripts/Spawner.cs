using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{

    [SerializeField] private float _spawnTimer = 0.0f;
    [SerializeField] public GameObject _snapPoint;
    [SerializeField] private GameObject _spawnCoal;
    [SerializeField] private int _stockCoal = 25;
    [SerializeField] private int _addCoal;
    [SerializeField] private GameObject _spawnIce0;
    [SerializeField] private GameObject _spawnIce1;
    [SerializeField] private GameObject _spawnIce2;
    [SerializeField] private GameObject _spawnIce3;
    [SerializeField] private int _timeSpawnIce0 = 10;
    [SerializeField] private int _timeSpawnIce1 = 10;
    [SerializeField] private int _timeSpawnIce2 = 10;
    [SerializeField] private int _timeSpawnIce3 = 10;

    void Update()
    {
        _spawnTimer += Time.deltaTime;

        if (_spawnTimer > 5.0f)
        {
            _spawnTimer = 0.0f;
            SpawnCoal();
            SpawnIce();
        }

        if (_spawnTimer > _timeSpawnIce0)
        {
            Item ice = DataBaseManager.Instance.dataBase.Ice;
            if (ice == null)
            {
                Debug.LogError("Missing Ice Reference");
            }
            else
            {
                Item newIce = Instantiate(ice);
                newIce.transform.position = _spawnIce0.transform.position;
            }

            _timeSpawnIce0 = 10;
        }

        if (_spawnTimer > _timeSpawnIce1)
        {
            Item ice = DataBaseManager.Instance.dataBase.Ice;
            if (ice == null)
            {
                Debug.LogError("Missing Ice Reference");
            }
            else
            {
                Item newIce = Instantiate(ice);
                newIce.transform.position = _spawnIce1.transform.position;
            }

            _timeSpawnIce1 = 10;
        }

        if (_spawnTimer > _timeSpawnIce2)
        {
            Item ice = DataBaseManager.Instance.dataBase.Ice;
            if (ice == null)
            {
                Debug.LogError("Missing Ice Reference");
            }
            else
            {
                Item newIce = Instantiate(ice);
                newIce.transform.position = _spawnIce2.transform.position;
            }

            _timeSpawnIce2 = 10;
        }

        if (_spawnTimer > _timeSpawnIce3)
        {
            Item ice = DataBaseManager.Instance.dataBase.Ice;
            if (ice == null)
            {
                Debug.LogError("Missing Ice Reference");
            }
            else
            {
                Item newIce = Instantiate(ice);
                newIce.transform.position = _spawnIce3.transform.position;
            }

            _timeSpawnIce3 = 10;
        }

        if(_stockCoal > 0)
        {
            _spawnCoal.SetActive(true);
        }
        else
        {
            _spawnCoal.SetActive(false);
        }
    }

    private void SpawnCoal()
    {
        _addCoal = Random.Range(2, 5);
        _stockCoal += _addCoal;
    }

    private void SpawnIce()
    {
        _timeSpawnIce0 = Random.Range(1, 4);
        _timeSpawnIce1 = Random.Range(1, 4);
        _timeSpawnIce2 = Random.Range(1, 4);
        _timeSpawnIce3 = Random.Range(1, 4);
    }

    public void TakeCoal()
    {
        _stockCoal--;
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(_spawnCoal.transform.position, 1.0f);
        Gizmos.DrawRay(_spawnCoal.transform.position, Vector3.up * 5);
    }
}
