# FontAwesomeを使用

BATTERY_FULL=""
BATTERY_THREE_QUARTER=""
BATTERY_HALF=""
BATTERY_QUARTER=""
BATTERY_EMPTY=""
BATTERY_CHARGEING=""

_get_icon(){
  if [ $value == 100 ]; then
      echo "${BATTERY_FULL}"
    elif [ $value -ge 75 ]&&[ $value -lt 100 ]; then
      echo "${BATTERY_THREE_QUARTER}"
    elif [ $value -ge 50 ] && [ $value -lt 75 ]; then
      echo "${BATTERY_HALF}"
    elif [ $value -ge 25 ] && [ $value -lt 50 ]; then
      echo "${BATTERY_QUARTER}"
    else  
      echo "${BATTERY_EMPTY}"
    fi  
}

run_segment() {
  info=$(pmset -g batt | tail -n 1)
  remaining=$(echo $info | awk '{ print $2 }' | sed -e 's/.$//')
  status=$(echo $info | awk '{ print $3 }' | sed -e 's/.$//')
  value=$(echo $remaining | sed -e 's/%//')

  if [ $status == 'discharging' ]; then
   wifi_icon=$(_get_icon) 
   echo "${wifi_icon} ${remaining}"
  elif [ $status == 'charging' ]; then
    echo "${BATTERY_CHARGEING} ${remaining}"
  elif [ $status == 'charged' ]; then
    echo "${BATTERY_CHARGEING} ${remaining}"
  else
    echo "${remaining}"
  fi
}
