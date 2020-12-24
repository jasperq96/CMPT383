## Starting the VM

This repository is designed to deploy itself into a virtual machine, managed by [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads). You should be able to change into the repository directory and type:
```sh
vagrant up
```
&hellip; to bring up a virtual machine. As part of creating the VM, Vagrant will run the Chef cookbook provided (described below).

Once you have the VM up, you can SSH into it and start running commands (and press ctrl-D to exit):
```sh
vagrant ssh
```

If you'd like to shut down or destroy the VM, you can do it with these commands:
```sh
vagrant halt
vagrant destroy
```

## The Cookbook

The [Chef cookbook](https://docs.chef.io/cookbooks/) that is provided in `cookbooks/polyglot/recipes/default.rb` and can be edited as necessary.

Most of the recipe is commented out: you can un-comment parts as necessary to install language tools or libraries as described there. If you need other libraries (e.g. Ruby on Rails, a Go package for some numeric computation), hopefully you can do it by analogy with the commented code in the recipe.

If you would like to re-run the recipe, you can ask Vagrant to do that:
```sh
vagrant provision
```

## SWIG computation
The SWIG components should be already computed, but incase they are not, run the following commands: 
```sh
swig -python -py3 -modern graphs.i
gcc -fPIC -c graphs.c graphs_wrap.c -I/usr/include/python3.8
ld -shared graphs.o graphs_wrap.o -o _graphs.so
```

## Python matplotlib
The Python server uses matplotlib to plot and save the spirograph, if it is not installed already, run the following:
```sh
pip3 install matplotlib
```

## How to run the system
You will need to open up two *command prompts*, one will be used to run the go server, the other will be to run the Python server. Once you *vagrant up*, you will need to do the following:
Run the GO server:
```sh
go run server.go
```

To run the Python server you will need to go into the *static* directory, then run the server:
```sh
cd static
python3 server_zmq.py
```

## Where to access the system
To access the website locally you will need to type the url *localhost:80*