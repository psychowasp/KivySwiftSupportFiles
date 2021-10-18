from PythonSwiftLink.build_app.gui_app import KivySwiftLink
from os.path import dirname,abspath
if __name__ == "__main__":
    KivySwiftLink(abspath(dirname(__file__))).run()
