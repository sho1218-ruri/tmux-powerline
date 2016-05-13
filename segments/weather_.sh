# Weather iconを使用
# OpenWeatherMapを使用
# APPID

# Thunderstorm
THUNDERSTORM_WITH_LIGHT_RAIN=200
THUNDERSTORM_WITH_RAIN=201
THUNDERSTORM_WITH_HEAVY_RAIN=202
LIGHT_THUNDERSTORM=210
THUNDERSTORM=211
HEAVY_THUNDERSTORM=212
RAGGED_THUNDERSTORM=221
THUNDERSTORM_WITH_LIGHT_DRIZZLE=230
THUNDERSTORM_WITH_DRIZZLE=231
THUNDERSTORM_WITH_HEAVY_DRIZZLE=232
# Drizzle
LIGHT_INTENSITY_DRIZZLE=300
DRIZZLE=301
HEAVY_INTENSITY_DRIZZLE=302
LIGHT_INTENSITY_DRIZZLE_RAIN=310
DRIZZLE_RAIN=311
HEAVY_INTENSITY_DRIZZLE_RAIN=312
SHOWER_RAIN_AND_DRIZZLE=313
HEAVY_SHOWER_RAIN_AND_DRIZZLE=314
SHOWER_DRIZZLE=321
# Rain
LIGHT_RAIN=500
MODERATE_RAIN=501
HEAVY_INTENSITY_RAIN=502
VERY_HEAVY_RAIN=502
EXTREME_RAIN=503
FREEZING_RAIN=504
LIGHT_INTENSITY_SHOWER_RAIN=511
SHOWER_RAIN=520
HEAVY_INTENSITY_SHOWER_RAIN=502
RAGGED_SHOWER_RAIN=531
# Snow
LIGHT_SNOW=600
SNOW=601
HEAVY_SNOW=602
SLEET=611
SHOWER_SLEET=612
LIGHT_RAIN_AND_SNOW=615
RAIN_AND_SNOW=616
LIGHT_SHOWER_SNOW=620
SHOWER_SNOW=621
HEAVY_SHOWER_SNOW=622
# Atmosphere
MIST=701
SMOKE=711
HAZE=721
SAND=731
FOG=741
SAND=751
DUST=761
VOLCANIC_ASH=762
SQUALLS=771
TORNADO=781
# Clear
CLEAR_SKY=800
# Clouds
FEW_CLOUDS=801
SCATTERED_CLOUDS=802
BROKEN_CLOUDS=803
OVERCAST_CLOUDS=804
# Extreme    
TORNADO=900
TROPICAL_STORM=901
HURRICANE=902
COLD=903
HOT=904
WINDY=905
HAIL=906
# Additional  
CALM=951
LIGHT_BREEZE=952
GENTLE_BREEZE=953
MODERATE_BREEZE=954
FRESH_BREEZE=955
STRONG_BREEZE=956
HIGH_WIND_NEAR_GALE=957
GALE=958
SEVERE_GALE=959
STORM=960
VIOLENT_STORM=961
HURRICANE=962

info=$(curl -s "http://api.openweathermap.org/data/2.5/weather?id=1850147&units=metric&appid=${OPENWEATHERMAP_APPID}")
weather=$(echo "$info" | jq -r .weather[].id)
temperature=$(echo "$info" | jq -r .main.temp | awk '{s=($0<0)?-1:1;print int($0*s*10+0.5)/10/s;}')

_get_icon() {
  case "${weather}" in
    "${THUNDERSTORM_WITH_LIGHT_RAINL}" | "${THUNDERSTORM_WITH_RAIN}" | "${LIGHT_THUNDERSTORM}" | "${THUNDERSTORM_WITH_LIGHT_DRIZZLE}" | "${THUNDERSTORM_WITH_DRIZZLE}" | "${THUNDERSTORM_WITH_HEAVY_DRIZZLE}") echo " ";;

    "${THUNDERSTORM_WITH_HEAVY_RAIN}" | "${THUNDERSTORM}" | "${HEAVY_THUNDERSTORM}" | "${RAGGED_THUNDERSTORM}") echo " ";;

    "${LIGHT_INTENSITY_DRIZZLE}" | "${DRIZZLE}" | "${HEAVY_INTENSITY_DRIZZLE}" | "${LIGHT_INTENSITY_DRIZZLE_RAIN}" | "${DRIZZLE_RAIN}" | "${HEAVY_INTENSITY_DRIZZLE_RAIN}" | "${SHOWER_RAIN_AND_DRIZZLE}" | "${HEAVY_SHOWER_RAIN_AND_DRIZZLE}" | "${SHOWER_DRIZZLE}") echo " ";;

    "${LIGHT_RAIN}") echo " ";;

    "${MODERATE_RAIN}" | "${FREEZING_RAIN}") echo " ";;

    "${HEAVY_INTENSITY_RAIN}" | "${VERY_HEAVY_RAIN}" | "${EXTREME_RAIN}") echo " ";;

    "${LIGHT_INTENSITY_SHOWER_RAIN}" | "${SHOWER_RAIN}" | "${HEAVY_INTENSITY_SHOWER_RAIN}" | "${RAGGED_SHOWER_RAIN}") echo " ";;

    "${LIGHT_SNOW}" | "${SNOW}") echo " ";;

    "${HEAVY_SNOW}" | "${LIGHT_SHOWER_SNOW}" | "${SHOWER_SNOW}" | "${HEAVY_SHOWER_SNOW}") echo " ";;

    "${SLEET}" | "${SHOWER_SLEET}" | "${LIGHT_RAIN_AND_SNOW}" | "${RAIN_AND_SNOW}") echo " ";;

    "${CLEAR_SKY}" | "${FEW_CLOUDS}") echo " ";; 

    "${SCATTERED_CLOUDS}" | "$BROKEN_CLOUDS") echo " ";;

    "${OVERCAST_CLOUDS}") echo " ";;

    *) echo " ";;
  esac
}

run_segment() {
  weather_icon=$(_get_icon)
  echo "${weather_icon} ${temperature}"
}
