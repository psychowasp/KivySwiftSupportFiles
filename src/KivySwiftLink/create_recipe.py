from os.path import join

PATCH_LIST = [
    "RECIPENAME",
    "MODULE_NAME",
    "MODULE_FOLDER",
    "CUSTOM_ROOT",
    "PY_VERSION",
    "OSX_VERSION"
    
    ]


RECIPE_PY = """\
from kivy_ios.toolchain import CythonRecipe

class {name}(CythonRecipe):
    version = "master"
    url = "src"
    library = "lib{name}.a"
    depends = ["python3", "hostpython3"]

    # Frameworks you used
    pbx_frameworks = ["Foundation", "UIKit"]

    def install(self):
        self.install_python_package(
            # Put the extension name here
            name=self.so_filename("{name}"), is_dir=False)

recipe = {name}()
"""
SETUP_PY = """\
from distutils.core import setup, Extension

setup(name='{name}',
      version='1.0',
      ext_modules=[
          Extension('{name}', # Put the name of your extension here
                    ['{name}.c', '_{name}.m'],
                    libraries=[],
                    library_dirs=[],
                    extra_compile_args=['-ObjC','-w'],
                    )
      ] 
    )
"""



def create_recipe(name: str) -> str:

    # with open(join(app_dir,"build_files","kivy_recipe.py")) as f:
    #     kivy_recipe = str(f.read()) 

    # d = recipe_dict
    # new_recipe = kivy_recipe

    # for patch in PATCH_LIST:
    #     if patch == "RECIPENAME":
    #         new_recipe = new_recipe.replace("RECIPENAME",d["module_title"])
    #     elif patch in ("MODULE_FOLDER", "CUSTOM_ROOT"):
    #         if d[patch] != None:
    #             new_recipe = new_recipe.replace(patch,f"{d[patch]}")
    #         else:
    #             new_recipe = new_recipe.replace(f"\"{patch}\"",f"{d[patch]}")
    #     else:
    #         new_recipe = new_recipe.replace(patch,f"{d[patch]}")
    new_recipe = RECIPE_PY.format(name=name)

    return new_recipe

def create_setup_py(name: str) -> str:
    return SETUP_PY.format(name=name)