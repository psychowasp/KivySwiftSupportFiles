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
#include "datetime.h"
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
Py_buffer *PythonMemoryView_GET_BUFFER(PyObject *mview);


void* PythonUnicode_DATA(PyObject *o);
unsigned int PythonUnicode_KIND(PyObject *o);

Py_UCS1 *PythonUnicode_1BYTE_DATA(PyObject *o);
Py_UCS2 *PythonUnicode_2BYTE_DATA(PyObject *o);
Py_UCS4 *PythonUnicode_4BYTE_DATA(PyObject *o);



PyObject* PythonDelta_FromDSU(int days, int seconds, int useconds);
PyObject* PythonNone;
PyObject* PythonTrue;
PyObject* PythonFalse;

#endif /* PyImports_h */
