WIFI_VERY_STRONG=""
WIFI_STRONG=""
WIFI_NORMAL=""
WIFI_WEAK=""

run_segment() {
  wifi=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)
  signal=$(echo "$wifi" | grep "\sagrCtlRSSI" | sed -e "s/[^:]*: //" | sed -e "s/-//")
  ssid=$(echo "$wifi" |grep "\sSSID"|sed -e "s/[^:]*: //")

  if [ ${signal} == 0 ]; then
    echo "No NetWork"  
  elif [ ${signal} - gt 0 ]&&[ ${signal} -le 39 ]; then
    echo "${WIFI_VERY_STRONG} ${ssid}"
  elif [ ${signal} -gt 39 ]&&[ ${signal} -le 49 ]; then
    echo "${WIFI_STRONG} ${ssid}"
  elif [ ${signal} -gt 49 ]&&[ ${signal} -le 59 ]; then
    echo "${WIFI_NORMAL} ${ssid}"
  elif [ ${signal} -gt 59 ]&&[ ${signal} -le 69 ]; then
    echo "${WIFI_WEAK} ${ssid}"
  else 
    echo "${WIFI_WEAK} ${ssid}"
  fi
}
