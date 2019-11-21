using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{

    [SerializeField] private float _spawnTimer = 0.0f;
    [SerializeField] public GameObject _snapPoint;
    [SerializeField] private GameObject _spawnCoal;
    [SerializeField] private int _stockCoal = 25;
    [SerializeField] private GameObject _spawnIce0;
    [SerializeField] private GameObject _spawnIce1;
    [SerializeField] private GameObject _spawnIce2;
    [SerializeField] private GameObject _spawnIce3;
    [SerializeField] private int _timeSpawnIce0;
    [SerializeField] private int _timeSpawnIce1;
    [SerializeField] private int _timeSpawnIce2;
    [SerializeField] private int _timeSpawnIce3;
    [SerializeField] private int _score = 0;

    void Start()
    {
        
    }

    void Update()
    {
        _spawnTimer += Time.deltaTime;

        if (_spawnTimer > 5.0f)
        {
            _spawnTimer = 0.0f;
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
        }
    }

    private void SpawnCoal()
    {
        Coal coal = DataBaseManager.Instance.dataBase.coal;
        if (coal == null)
        {
            Debug.LogError("Missing Coal Reference");
        }
        else
        {
            Coal newCoal = Instantiate(coal);

            newCoal.transform.position = _spawnCoal.transform.position;

            newCoal.SpawnerManager = this;
        }
    }

    private void SpawnIce()
    {
        _timeSpawnIce0 = Random.Range(1, 4);
        _timeSpawnIce1 = Random.Range(1, 4);
        _timeSpawnIce2 = Random.Range(1, 4);
        _timeSpawnIce3 = Random.Range(1, 4);
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(_spawnCoal.transform.position, 1.0f);
        Gizmos.DrawRay(_spawnCoal.transform.position, Vector3.up * 5);
    }
}
