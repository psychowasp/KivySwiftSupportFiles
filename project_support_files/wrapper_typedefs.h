//data
//typedef unsigned char const* PythonData;
typedef struct PythonData {
	unsigned char const* _Nonnull ptr;
	long size;
} PythonData;
//str
typedef char const* _Nonnull PythonString;

//bytes
typedef const char * _Nonnull PythonBytes;

//object
typedef const void * _Nonnull PythonObject;

//json
typedef char const* _Nonnull PythonJsonString;

//jsondata
//typedef unsigned char const* PythonJsonData;
typedef struct PythonJsonData { 
	unsigned char const* _Nonnull ptr;
	long size;
} PythonJsonData;

//list_int
typedef struct PythonList_Int {
	long const* _Nonnull ptr;
	long size;
} PythonList_Int;
//list_uint
typedef struct PythonList_UInt {
	unsigned long const* _Nonnull ptr;
	long size;
} PythonList_UInt;

//list_int32
typedef struct PythonList_Int32 {
	int const* _Nonnull ptr;
	long size;
} PythonList_Int32;

//list_uint32
typedef struct PythonList_UInt32 {
	unsigned int const* _Nonnull ptr;
	long size;
} PythonList_UInt32;
//list_longlong
//typedef const long long * _Nonnull PythonList_Int64;

//list_ulonglong
//typedef const unsigned long long * _Nonnull PythonList_UInt64;

//list_uint8
//typedef const unsigned char * _Nonnull PythonList_UInt8;
typedef struct PythonList_UInt8 {
	unsigned char const* _Nonnull ptr;
	long size;
} PythonList_UInt8;
//list_int16
typedef struct PythonList_Int16 {
	short const* _Nonnull ptr;
	long size;
} PythonList_Int16;
//list_uint16
typedef struct PythonList_UInt16 {
	unsigned short const* _Nonnull ptr;
	long size;
} PythonList_UInt16;
//list_double
typedef struct PythonList_Double {
	double const* _Nonnull ptr;
	long size;
} PythonList_Double;
//list_float32
typedef struct PythonList_Float {
	float const* _Nonnull ptr;
	long size;
} PythonList_Float;
//list_object
typedef struct PythonList_PythonObject {
	void const* _Nonnull ptr;
	long size;
} PythonList_PythonObject;
//list_string
typedef struct PythonList_PythonString {
	char const* _Nonnull const* _Nonnull ptr;
	long size;
} PythonList_PythonString;



//list PythonJsonData
typedef struct PythonList_PythonData { 
	PythonData const* _Nonnull ptr;
	long size;
} PythonList_PythonData;
//list_data
typedef struct PythonList_PythonJsonData { 
	PythonJsonData const* _Nonnull ptr;
	long size;
} PythonList_PythonJsonData;