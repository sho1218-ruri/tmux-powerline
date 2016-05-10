WIFI_VERY_STRONG=""
WIFI_STRONG=""
WIFI_NORMAL=""
WIFI_WEAK=""

run_segment() {
  wifi_signal=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep "\sagrCtlRSSI" | sed -e "s/[^:]*: //" | sed -e "s/-//")
  wifi_ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I |grep "\sSSID"|sed -e "s/[^:]*: //")

  if [ $wifi_signal -le 39 ]; then
    echo "${WIFI_VERY_STRONG} ${wifi_ssid}"
  elif [ $wifi_signal -gt 39 ]&&[ $wifi_signal -le 49 ]; then
    echo "${WIFI_STRONG} ${wifi_ssid}"
  elif [ $wifi_signal -gt 49 ]&&[ $wifi_signal -le 59 ]; then
    echo "${WIFI_NORMAL} ${wifi_ssid}"
  elif [ $wifi_signal -gt 59 ]&&[ $wifi_signal -le 69 ]; then
    echo "${WIFI_WEAK} ${wifi_ssid}"
  else 
    echo "${WIFI_WEAK}"
  fi
}
