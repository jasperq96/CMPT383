# CMPT383_Final
Topic: Web-based application that takes in user input to create a single/multiple unique spirographs.  

Three programming languages used and their role:

C - Does the calculations.

Python - Runs ZeroMQ server and takes requests, calls SWIG python functions (converted C++ functions) to generate graphs and return. 

Go - Run webserver and make requests to ZeroMQ Python server. User uses website to choose type of graph and input required fields to be sent to python server.

Two inter-language communication methods

SWIG
ZeroMQ

Deployment Technology:
Vagrant VM