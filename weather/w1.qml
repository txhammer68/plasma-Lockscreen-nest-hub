import QtQuick 2.9
import org.kde.plasma.private.weather 1.0
import org.kde.plasma.core 2.0

Item {
    id: root
    //readonly property string weatherSource: "wettercom|weather|La Porte, Texas, US|US0TX0706;La Porte"
    //noaa|weather|current_obs|KEFD
    //noaa|weather|Houston,TX|KEFD
   // noaa|weather||Houston,TX|lat=29.6&lon=-95.16667
    // noaa|weather|Houston, Houston Hobby Airport (KHOU)
    //readonly property string weatherSource: 'noaa|weather|New York City, Central Park, NY'
    readonly property string weatherSource: 'noaa|weather|Houston / Ellington, TX'
    readonly property int updateInterval: 30

    DataSource {
        id: weatherDataSource

        readonly property var currentData: data[weatherSource]

        engine: "weather"
        connectedSources: weatherSource
        interval: updateInterval * 60 * 1000
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


    readonly property var weatherData: weatherDataSource.currentData || {}

    readonly property int invalidUnit: -1 //TODO: make KUnitConversion::InvalidUnit usable here

    function formatTemp(value) {
        if (value === "N/U") {
            return ""
        } else if (value === "N/A" || !value) {
            return i18ndc("org.kde.plasma.weather", "Short for no data available", "-")
        } else {
            var reportUnit = weatherData["Temperature Unit"] || invalidUnit
            var temp = weatherData["Temperature"] || invalidUnit
            var displayUnit = reportUnit // TODO: Check for user locale/configured unit
            return Util.valueToDisplayString(displayUnit, value, reportUnit, 1)
        }
    }
    
    Text {
        text: weatherData["Temperature"] + " " + weatherData["Current Conditions"]+ "  " + weatherData["Condition Icon"]
        font.pointSize:24
    }
    
    
        
    
}
