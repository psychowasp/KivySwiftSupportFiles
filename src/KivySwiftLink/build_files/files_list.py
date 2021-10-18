import configparser
import os
import json



#config = configparser.ConfigParser()

def open_config(path:str)->dict:
    print(os.path.join(path,"compile_modules.ini"))

    try:
        with open(os.path.join(path,"compile_modules.ini"), 'r') as configfile:
            _str = configfile.read()
            # print(_str)
            # _list = json.loads(_str)
            # _key,_dict = _list
            # modules[_key] = _dict
            configfile.close()
        return json.loads(_str)
    except:
        print("import error")
        return {}







if __name__ == "__main__":
    open_config()