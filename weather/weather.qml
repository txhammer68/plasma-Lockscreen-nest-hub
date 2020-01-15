import QtQuick 2.9
import org.kde.plasma.private.weather 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
 
 Item {
    id: root
      // readonly property string weatherSource: "US0TX0706;La Porte"
    readonly property string weatherSource: "wettercom|weather|La Porte, Texas, US|US0TX0706;La Porte"
    // readonly property string weatherSource: 'wettercom|weather|London, London, GB|GB0KI0101;London'
     //  wettercom|weather|Turin, Piemont, IT|IT0PI0397;Turin
    readonly property int updateInterval: 30
    readonly property int displayTemperatureUnit: 1
    readonly property int displaySpeedUnit: 1
    readonly property int displayPressureUnit: 1
    readonly property int displayVisibilityUnit: 1

    property bool connectingToSource: false
    readonly property bool needsConfiguration: !generalModel.location && !connectingToSource

    readonly property int invalidUnit: -1 //TODO: make KUnitConversion::InvalidUnit usable here

     // var temperature = plasmoid.nativeInterface.temperatureShownInTooltip ? observationModel.temperature : null;
     

 PlasmaCore.DataSource {
        id: weatherDataSource

        readonly property var currentData: data[weatherSource]

        engine: "weather"
        connectedSources: weatherSource
        // interval: updateInterval * 60 * 1000
        interval:  1 * 6 * 1000
        onConnectedSourcesChanged: {
            if (weatherSource) {
                connectingToSource = true;
                // plasmoid.busy = true;
                connectionTimeoutTimer.start();
            }
        }
        onCurrentDataChanged: {
            if (currentData) {
                connectionTimeoutTimer.stop();
                connectingToSource = false;
                // plasmoid.busy = false;
            }
        }
    }
    
    
        readonly property var observationModel: {
        var model = {};
        var data = weatherDataSource.currentData || {};
        var temperature = observationModel.temperature

        function getNumber(key) {
            var number = data[key];
            if (typeof number === "string") {
                var parsedNumber = parseFloat(number);
                return isNaN(parsedNumber) ? null : parsedNumber;
            }
            return (typeof number !== "undefined") && (number !== "") ? number : null;
        }
        function getNumberOrString(key) {
            var number = data[key];
            return (typeof number !== "undefined") && (number !== "") ? number : null;
        }

        var reportTemperatureUnit = data["Temperature Unit"] || invalidUnit;
        var reportPressureUnit =    data["Pressure Unit"] || invalidUnit;
        var reportVisibilityUnit =  data["Visibility Unit"] || invalidUnit;
        var reportWindSpeedUnit =   data["Wind Speed Unit"] || invalidUnit;
        // var reportTemperatureUnit = (data && data["Temperature Unit"]) || invalidUnit;

        model["conditions"] = data["Current Conditions"] || "";

        var conditionIconName = data["Condition Icon"] || null;
        model["conditionIconName"] = conditionIconName ? Util.existingWeatherIconName(conditionIconName) : "weather-none-available";

        var temperature = getNumber("Temperature");
        model["temperature"] = temperature !== null ? Util.temperatureToDisplayString(displayTemperatureUnit, temperature, reportTemperatureUnit) : "";
        console.log(model["temperature"]);
        
        var windchill = getNumber("Windchill");
        // Use temperature unit to convert windchill temperature
        // we only show degrees symbol not actual temperature unit
        model["windchill"] = windchill !== null ?
            Util.temperatureToDisplayString(displayTemperatureUnit, windchill, reportTemperatureUnit, false, true) :
            "";

        var humidex = getNumber("Humidex");
        // TODO: this seems wrong, does the humidex have temperature as units?
        // Use temperature unit to convert humidex temperature
        // we only show degrees symbol not actual temperature unit
        model["humidex"] = humidex !== null ?
            Util.temperatureToDisplayString(displayTemperatureUnit, humidex, reportTemperatureUnit, false, true) :
            "";

        var dewpoint = getNumber("Dewpoint");
        model["dewpoint"] = dewpoint !== null ?
            Util.temperatureToDisplayString(displayTemperatureUnit, dewpoint, reportTemperatureUnit) : "";

        var pressure = getNumber("Pressure");
        model["pressure"] = pressure !== null ?
            Util.valueToDisplayString(displayPressureUnit, pressure, reportPressureUnit, 2) : "";

        var pressureTendency = (data && data["Pressure Tendency"]) || null;
        model["pressureTendency"] =
            pressureTendency === "rising"  ? i18nc("pressure tendency", "Rising")  :
            pressureTendency === "falling" ? i18nc("pressure tendency", "Falling") :
            pressureTendency === "steady"  ? i18nc("pressure tendency", "Steady")  :
            /* else */                       "";

        var visibility = getNumberOrString("Visibility");
        model["visibility"] = visibility !== null ?
            ((reportVisibilityUnit !== invalidUnit) ?
                Util.valueToDisplayString(displayVisibilityUnit, visibility, reportVisibilityUnit, 1) : visibility) :
            "";

        var humidity = getNumber("Humidity");
        model["humidity"] = humidity !== null ? Util.percentToDisplayString(humidity) : "";

        // TODO: missing check for windDirection validness
        var windDirection = data["Wind Direction"] || "";
        var windSpeed = getNumberOrString("Wind Speed");
        var windSpeedText;
        if (windSpeed !== null && windSpeed !== "") {
            var windSpeedNumeric = (typeof windSpeed !== 'number') ? parseFloat(windSpeed) : windSpeed;
            if (!isNaN(windSpeedNumeric)) {
                if (windSpeedNumeric !== 0) {
                    windSpeedText = Util.valueToDisplayString(displaySpeedUnit, windSpeedNumeric, reportWindSpeedUnit, 1);
                } else {
                    windSpeedText = i18nc("Wind condition", "Calm");
                }
            } else {
                // TODO: i18n?
                windSpeedText = windSpeed;
            }
        }
        model["windSpeed"] = windSpeedText || "";
        model["windDirectionId"] = windDirection;
        model["windDirection"] = windDirection ? i18nc("wind direction", windDirection) : "";

        var windGust = getNumber("Wind Gust");
        model["windGust"] = windGust !== null ? Util.valueToDisplayString(displaySpeedUnit, windGust, reportWindSpeedUnit, 1) : "";

        return model;
    }
    
  //  var weatherIconName = forecastDayTokens[1];
   //         if (weatherIconName && weatherIconName !== "N/U") {
    //            var iconAndToolTip = Util.existingWeatherIconName(weatherIconName);
    
                
   // model["currentConditionIconName"] = conditionIconName;

   //     return model;
  //  }
    
    
    Item {
        
        Text {
            text : temperature
            // text: "TEST"
            color:"black"
        }
    }
    
    Timer {
        id: connectionTimeoutTimer

        interval: 60 * 1000 // 1 min
        repeat: false
        onTriggered: {
            connectingToSource = false;
            plasmoid.busy = false;
            // TODO: inform user
            var sourceTokens = weatherSource.split("|");
            var foo = i18n("Weather information retrieval for %1 timed out.", sourceTokens.value(2));
        }
    }
 }
