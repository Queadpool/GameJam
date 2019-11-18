using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DataBaseManager : MonoBehaviour
{
    public DataBase dataBase;
    private static DataBaseManager _instance = null;

    public static DataBaseManager Instance
    {
        get
        {
            if (_instance == null)
            {
                DataBaseManager[] foundObjects = FindObjectsOfType<DataBaseManager>();
                if (foundObjects != null && foundObjects.Length < 2)
                {
                    _instance = foundObjects[0];
                }
                else
                {
                    Debug.LogError("Problème DataBase");
                }
            }
            return _instance;
        }
    }
}
