﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Rewired;

public class PlayerController : MonoBehaviour
{

    //[SerializeField] private Camera _camera;

    [SerializeField] private float _speed = 6.0F;
    [SerializeField] private float _gravity = 20.0F;
    [SerializeField] private Vector3 moveDirection = Vector3.zero;
    [SerializeField] private float _rotSpeed = 5.0f;
    [SerializeField] private float _rotAngle = 45.0f;

    [SerializeField] private CharacterController _characterCollider;
    [SerializeField] private CharacterController _controller;
    [SerializeField] private ItemsManagement _itemsManagement;

    [SerializeField] private int _playerID = 0;
    [SerializeField] private Player _player; 

    // Use this for initialization
    void Start()
    {
        _characterCollider = gameObject.GetComponent<CharacterController>();
        _controller = GetComponent<CharacterController>();
        _itemsManagement = gameObject.GetComponent<ItemsManagement>();

        _player = ReInput.players.GetPlayer(_playerID);
    }

    // Update is called once per frame
    void Update()
    {
        ComputeMove();

            if (_player.GetButtonDown("Drop"))
        {
            _itemsManagement.Drop();
        }

        if (moveDirection != Vector3.zero)
        {
            Rotate();
        }

        DoMove();
    }

    private void ComputeMove()
    {
        if (_controller.isGrounded)
        {
            moveDirection = new Vector3(_player.GetAxis("Move Horizontal"), 0, _player.GetAxis("Move Vertical")).normalized;
            //moveDirection = _camera.transform.TransformDirection(moveDirection);
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
            if (_player.GetButtonDown("Pick Up"))
            {
                _itemsManagement.PickUp(other.gameObject);
            }
        }
        else if (other.gameObject.layer == 10)
        {
            if (_player.GetButtonDown("Use"))
            {
                _itemsManagement.Use(other.gameObject.GetComponent<Egg>());
            }
        }
    }

}
