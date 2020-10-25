#!/bin/sh
# backup_server_launcher.sh
# launches correct python scripts with directory management

cd ~/pinpoint_exp2
sleep 10
python3 -u concat_dataframes.py >> logs/logs_coallate 2>&1 &
exit 0
