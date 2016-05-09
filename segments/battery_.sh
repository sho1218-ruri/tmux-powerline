# FontAwesomeを使用

BATTERY_FULL=""
BATTERY_THREE_QUARTER=""
BATTERY_HALF=""
BATTERY_QUARTER=""
BATTERY_EMPTY=""
BATTERY_CHARGEING=""

run_segment() {
  info=$(pmset -g batt | tail -n 1)
  remaining=$(echo $info | awk '{ print $2 }' | sed -e 's/.$//')
  status=$(echo $info | awk '{ print $3 }' | sed -e 's/.$//')
  value=$(echo $remaining | sed -e 's/%//')

  if [ $status == 'discharging' ]; then
    if [ $value -ge 75 ]&&[ $value -lt 100 ]; then
      echo "${BATTERY_THREE_QUARTER} ${remaining}"
    elif [ $value -ge 50 ] && [ $value -lt 75 ]; then
      echo "${BATTERY_HALF} ${remaining}"
    elif [ $value -ge 25 ] && [ $value -lt 50 ]; then
      echo "${BATTERY_QUARTER} ${remaining}"
    else  
      echo "${BATTERY_EMPTY} ${remaining}"
    fi
  elif [ $status == 'charging' ]; then
    echo "${BATTERY_CHARGEING} ${remaining}"
  elif [ $status == 'charged' ]; then
    echo "${BATTERY_FULL} ${remaining}"
  else
    echo "${remaining}"
  fi
}
