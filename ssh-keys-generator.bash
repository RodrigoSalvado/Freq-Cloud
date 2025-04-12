#!/bin/bash

puttygen -t rsa -b 4096 -o chave_privada.ppk

puttygen chave_privada.ppk -L > chave_publica.pub
