//
//  PyImports.h
//  metacam
//
//  Created by MusicMaker on 26/02/2022.
//
#ifndef PyImports_h
#define PyImports_h

#include <stdio.h>
#include <stdbool.h>

#include "Python.h"
bool PythonDict_Check(PyObject* o);
int _PythonDict_Check(PyObject* o);
bool PythonTuple_Check(PyObject* o);
bool PythonList_Check(PyObject* o);
bool PythonUnicode_Check(PyObject* o);
bool PythonLong_Check(PyObject *o);
bool PythonFloat_Check(PyObject *o);
bool PythonBool_Check(PyObject *o);
bool PythonByteArray_Check(PyObject *o);
bool PythonBytes_Check(PyObject *o);
PyObject** PythonSequence_Fast_ITEMS(PyObject *o);
PyObject* PythonSequence_Fast_GET_ITEM(PyObject *o, Py_ssize_t i);
Py_ssize_t PythonSequence_Fast_GET_SIZE(PyObject *o);
PyObject* PythonNone;


#endif /* PyImports_h */
