//
//  PyImports.c
//  metacam
//
//  Created by MusicMaker on 26/02/2022.
//

#include "PyImports.h"

bool PythonDict_Check(PyObject* o) { return PyDict_Check(o) == 1; }
int _PythonDict_Check(PyObject* o) { return PyDict_Check(o); }
bool PythonTuple_Check(PyObject* o) { return PyTuple_Check(o) == 1; }
bool PythonList_Check(PyObject* o) { return PyList_Check(o) == 1; }
bool PythonUnicode_Check(PyObject* o) { return PyUnicode_Check(o) == 1; }
bool PythonLong_Check(PyObject *o) { return PyLong_Check(o) == 1; }
bool PythonFloat_Check(PyObject *o) { return PyFloat_Check(o) == 1; }
bool PythonBool_Check(PyObject *o){ return PyBool_Check(o) == 1; }
bool PythonByteArray_Check(PyObject *o) { return PyByteArray_Check(o) == 1; }
bool PythonBytes_Check(PyObject *o) { return PyBytes_Check(o) == 1; }


PyObject** PythonSequence_Fast_ITEMS(PyObject *o) { return PySequence_Fast_ITEMS(o); }
PyObject* PythonSequence_Fast_GET_ITEM(PyObject *o, Py_ssize_t i) { return PySequence_Fast_GET_ITEM(o, i); }
Py_ssize_t PythonSequence_Fast_GET_SIZE(PyObject *o) { return PySequence_Fast_GET_SIZE(o); }

PyObject* PythonDelta_FromDSU(int days, int seconds, int useconds) { return PyDelta_FromDSU(days, seconds, useconds);}
Py_buffer *PythonMemoryView_GET_BUFFER(PyObject *mview) { return PyMemoryView_GET_BUFFER(mview);}

void* PythonUnicode_DATA(PyObject *o) { return PyUnicode_DATA(o);}
unsigned int PythonUnicode_KIND(PyObject *o) {return  PyUnicode_KIND(o);}

Py_UCS1 *PythonUnicode_1BYTE_DATA(PyObject *o) { return PyUnicode_1BYTE_DATA(o); }
Py_UCS2 *PythonUnicode_2BYTE_DATA(PyObject *o) { return PyUnicode_2BYTE_DATA(o); }
Py_UCS4 *PythonUnicode_4BYTE_DATA(PyObject *o) { return PyUnicode_4BYTE_DATA(o); }
PyObject* PythonNone = Py_None;
PyObject* PythonTrue = Py_True;
PyObject* PythonFalse = Py_False;
