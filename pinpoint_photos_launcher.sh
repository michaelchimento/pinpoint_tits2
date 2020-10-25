#!/bin/sh
# backup_server_launcher.sh
# launches correct python scripts with directory management

cd ~/pinpoint_exp2
sleep 10
python3 -u photo_data_analysis.py P1 > logs/logsP1 2>&1 &
python3 -u photo_data_analysis.py P2 > logs/logsP2 2>&1 &
python3 -u photo_data_analysis.py P3 > logs/logsP3 2>&1 &
python3 -u photo_data_analysis.py P4 > logs/logsP4 2>&1 &
python3 -u photo_data_analysis.py P5 > logs/logsP5 2>&1 &
python3 -u photo_data_analysis.py P6 > logs/logsP6 2>&1 &
python3 -u photo_data_analysis.py P7 > logs/logsP7 2>&1 &
python3 -u photo_data_analysis.py P8 > logs/logsP8 2>&1 &
python3 -u photo_data_analysis.py P9 > logs/logsP9 2>&1 &
python3 -u photo_data_analysis.py P10 > logs/logsP10 2>&1 &
exit 0
