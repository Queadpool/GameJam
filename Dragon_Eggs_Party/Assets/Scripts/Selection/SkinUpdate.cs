using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SkinUpdate : MonoBehaviour
{
    [SerializeField] private PlayersManager _playersManager;
    [SerializeField] private int _playerID = 0;
    [SerializeField] private Dragons _dragonsList;

    private GameObject _skin;
    private int colour;

    // Start is called before the first frame update
    void Start()
    {
        _playersManager = FindObjectOfType<PlayersManager>();
        _skin = _playersManager.GetSkin(_playerID);
        if (_skin != null)
        {
            _skin = Instantiate(_skin, transform.position, Quaternion.identity);
            _skin.transform.parent = this.transform.parent;
        }

    }
}
