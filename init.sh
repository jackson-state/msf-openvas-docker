#!/bin/bash
msfrpcd -P msf_test -S -a 127.0.0.1
nohup bash -c "/start &"
bash