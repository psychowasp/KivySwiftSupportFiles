//data
//typedef unsigned char const* PythonData;
#ifndef wrapper_typedefs_h
#define wrapper_typedefs_h

#include "python.h"
typedef struct {
	unsigned char const* _Nonnull ptr;
	long size;
} PythonData;
//str
typedef char const* _Nonnull PythonString;

//bytes
typedef const char * _Nonnull PythonBytes;

//object
//typedef PyObject* _Nonnull PythonObject;

typedef PyObject* _Nullable PyPtr;

typedef void const* _Nonnull CythonClass;

//json
typedef char const* _Nonnull PythonJsonString;

//jsondata
//typedef unsigned char const* PythonJsonData;
typedef struct { 
	unsigned char const* _Nonnull ptr;
	long size;
} PythonJsonData;

//list_int
typedef struct {
	long const* _Nonnull ptr;
	long size;
} PythonList_Int;
//list_uint
typedef struct {
	unsigned long const* _Nonnull ptr;
	long size;
} PythonList_UInt;

//list_int32
typedef struct {
	int const* _Nonnull ptr;
	long size;
} PythonList_Int32;

//list_uint32
typedef struct {
	unsigned int const* _Nonnull ptr;
	long size;
} PythonList_UInt32;
//list_longlong
//typedef const long long * _Nonnull PythonList_Int64;

//list_ulonglong
//typedef const unsigned long long * _Nonnull PythonList_UInt64;

//list_uint8
//typedef const unsigned char * _Nonnull PythonList_UInt8;
typedef struct {
	unsigned char const* _Nonnull ptr;
	long size;
} PythonList_UInt8;
//list_int16
typedef struct {
	short const* _Nonnull ptr;
	long size;
} PythonList_Int16;
//list_uint16
typedef struct {
	unsigned short const* _Nonnull ptr;
	long size;
} PythonList_UInt16;
//list_double
typedef struct PythonList_Double {
	double const* _Nonnull ptr;
	long size;
} PythonList_Double;
//list_float32
typedef struct {
	float const* _Nonnull ptr;
	long size;
} PythonList_Float;
//list_object
typedef struct {
    const PythonPointer * ptr;
    //const PythonObject * ptr;
	long size;
} PythonList_PythonObject;
//list_string
typedef struct {
	const PythonString * ptr;
	long size;
} PythonList_PythonString;



//list PythonJsonData
typedef struct { 
	PythonData const* _Nonnull ptr;
	long size;
} PythonList_PythonData;
//list_data
typedef struct { 
	PythonJsonData const* _Nonnull ptr;
	long size;
} PythonList_PythonJsonData;


#endif /* wrapper_typedefs_h */
