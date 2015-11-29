from setuptools import setup, find_packages
import functools
import os

_in_same_dir = functools.partial(os.path.join, os.path.dirname(__file__))

with open(_in_same_dir("src", "__version__.py")) as version_file:
    exec(version_file.read())  # pylint: disable=W0122

install_requires = [
    "something",
]
setup(name="project",
      classifiers=[
          "Programming Language :: Python :: 3.5",
      ],
      description="A Testing Framework",
      license="BSD",
      author="Roey Darwish Dror",
      author_email="roey.ghost@gmail.com",
      url="",
      version=__version__,  # pylint: disable=E0602
      packages=find_packages(exclude=["tests"]),
      install_requires=install_requires,
    #   entry_points=dict(
    #       console_scripts=[
    #           "slash  = slash.frontend.main:main_entry_point",
    #       ]
    #   ),
)
