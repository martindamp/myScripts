#!/bin/bash
sudo chmod 777 /proc/acpi/ibm/fan
echo "Starting fanspeed adjust app"
state="low"
val=$(echo level 5 > /proc/acpi/ibm/fan)
echo "Switching to low state"
lowhval=45
highval=80
waittime=10

while true
do
    core0=$(sensors | sed -nE '/Core 0:/s/[^+]*\+([[:digit:]]+).*/\1/p')
    
    echo "$core0"
    

    if [ "$core0" -gt "$highval" ]; then
        if [ $state != "high" ]; then    
            state="high"
            val=$(echo level disengaged > /proc/acpi/ibm/fan)
            waittime=60
            echo "Switching to high state"
        fi
        echo "Its hot"
    else
        if [ "$core0" -lt "$lowhval" ]; then
            if [ $state != "low" ]; then
                state="low"
                val=$(echo level 5 > /proc/acpi/ibm/fan)
                waittime=20
                echo "Switching to low state"

            fi 
        else
            if [ $state != "medium" ]; then    
                state="medium"
                val=$(echo level 7 > /proc/acpi/ibm/fan)
                waittime=10
                echo "Switching to medium state"
            fi
        fi
    fi
    echo "$state"
    

    sleep $waittime
done