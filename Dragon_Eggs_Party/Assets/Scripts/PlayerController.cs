using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rewired;

public class PlayerController : MonoBehaviour
{
    [SerializeField] private float _speed = 6.0F;
    [SerializeField] private float _gravity = 20.0F;
    [SerializeField] private Vector3 moveDirection = Vector3.zero;
    [SerializeField] private float _rotSpeed = 5.0f;

    [SerializeField] private CharacterController _characterCollider;
    [SerializeField] private CharacterController _controller;
    [SerializeField] private ItemManagement _itemManagement;
    [SerializeField] private Spawner _spawner;
    [SerializeField] private GameObject _snapPoint;

    [SerializeField] private int _playerID = 0;
    [SerializeField] private Player _player;

    private bool _hasItem = false;


    void Start()
    {
        _characterCollider = gameObject.GetComponent<CharacterController>();
        _controller = GetComponent<CharacterController>();
        _itemManagement = GetComponent<ItemManagement>();
        _player = ReInput.players.GetPlayer(_playerID);
    }

    void Update()
    {
        ComputeMove();

        if (moveDirection != Vector3.zero)
        {
            Rotate();
        }

        if (_player.GetButtonDown("Drop"))
        {
            _itemManagement.Drop();
        }

        DoMove();
    }

    private void ComputeMove()
    {
        if (_controller.isGrounded)
        {
            moveDirection = new Vector3(_player.GetAxis("Move Horizontal"), 0, _player.GetAxis("Move Vertical")).normalized;
            moveDirection *= _speed;
        }
    }

    private void DoMove()
    {
        moveDirection.y -= _gravity * Time.deltaTime;
        _controller.Move(moveDirection * Time.deltaTime);
    }

    private void Rotate()
    {
        Vector3 lookDirection = moveDirection;
        lookDirection.y = 0;

        Quaternion rotation = Quaternion.LookRotation(lookDirection);
        transform.rotation = Quaternion.Slerp(transform.rotation, rotation, _rotSpeed * Time.deltaTime);
    }

    private void OnTriggerStay(Collider other)
    {
        if (other.gameObject.layer == 9)
        {
            if (_player.GetButtonDown("Pick Up") && other.tag != "Spawn")
            {        
                _itemManagement.PickUp(other.gameObject.GetComponent<Item>());
            }

            if (other.tag == "Spawn")
            {
                _spawner.TakeCoal();

                Item coal = DataBaseManager.Instance.dataBase.Coal;
                if (coal == null)
                {
                    Debug.LogError("Missing Coal Reference");
                }
                else
                {
                    _itemManagement.PickUp(coal, false);
                }
            }

            if (other.gameObject.layer == 10)
            {
                Debug.Log("Egg");
                _itemManagement.Use(other.gameObject);
            }
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.layer == 10)
        {
            Debug.Log("Egg");
        }
    }
}
