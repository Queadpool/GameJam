using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{

    [SerializeField] private float _spawnTimer = 0.0f;
    [SerializeField] public GameObject _snapPoint;
    [SerializeField] private GameObject _spawnCoal;
    [SerializeField] private Vector3 _randomSpawnCoal;
    [SerializeField] private Vector3 _newSpawnCoal;
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
            SpawnCoal();
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
            // Spawn fixe
            newCoal.transform.position = _spawnCoal.transform.position;

            // Spawn aléatoire dans une zone prédéfinie
            //_randomSpawnCoal = Random.insideUnitSphere;
            //_randomSpawnCoal.y = 0;
            //_newSpawnCoal = _spawnCoal.transform.position + _randomSpawnCoal;
            //newCoal.transform.position = _newSpawnCoal;

            newCoal.SpawnerManager = this;
        }
    }

    public void CoalDropToThePoele()
    {
        _score++;
        Debug.Log(_score);
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(_spawnCoal.transform.position, 1.0f);
        Gizmos.DrawRay(_spawnCoal.transform.position, Vector3.up * 5);
    }
}
