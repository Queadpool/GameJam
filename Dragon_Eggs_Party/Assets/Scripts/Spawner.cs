using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : MonoBehaviour
{

    [SerializeField] private float _spawnTimer = 0.0f;
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
    [SerializeField] private float _lavaTimer = 0.0f;
    [SerializeField] private bool _isLava = false;
    [SerializeField] private int _spawnLava;
    [SerializeField] private GameObject _lava0;
    [SerializeField] private GameObject _lava1;
    [SerializeField] private GameObject _lava2;
    [SerializeField] private GameObject _lava3;

    void Update()
    {
        _spawnTimer += Time.deltaTime;
        _lavaTimer += Time.deltaTime;

        if (_spawnTimer > 10.0f)
        {
            SpawnCoal();
            SpawnIce();
        }

        if (_lavaTimer > 10.0f)
        {
            if (!_isLava)
            {
                DoLava();
            }
            else
            {
                StopLava();
            }
        }
        

        if(_stockCoal > 0)
        {
            _spawnCoal.SetActive(true);
        }
        else
        {
            _spawnCoal.SetActive(false);
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
    }

    private void SpawnCoal()
    {
        _spawnTimer = 0.0f;
        _addCoal = Random.Range(2, 5);
        _stockCoal += _addCoal;
    }

    private void SpawnIce()
    {
        _timeSpawnIce0 = Random.Range(1, 6);
        _timeSpawnIce1 = Random.Range(1, 6);
        _timeSpawnIce2 = Random.Range(1, 6);
        _timeSpawnIce3 = Random.Range(1, 6);
    }

    public void DoLava()
    {
        _lavaTimer = 0.0f;
        _isLava = true;
        _spawnLava = Random.Range(0, 4);

        switch (_spawnLava)
        {
            case 0:
                {
                    _lava0.SetActive(true);
                    break;
                }
            case 1:
                {
                    _lava1.SetActive(true);
                    break;
                }
            case 2:
                {
                    _lava2.SetActive(true);
                    break;
                }
            case 3:
                {
                    _lava3.SetActive(true);
                    break;
                }
        }
    }

    public void StopLava()
    {
        _lavaTimer = 0.0f;
        _isLava = false;
        _lava0.SetActive(false);
        _lava1.SetActive(false);
        _lava2.SetActive(false);
        _lava3.SetActive(false);
    }

    public void TakeCoal()
    {
        _stockCoal--;
    }
}
