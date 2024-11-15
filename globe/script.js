/**
 * ---------------------------------------
 * This demo was created using amCharts 5.
 * 
 * For more information visit:
 * https://www.amcharts.com/
 * 
 * Documentation is available at:
 * https://www.amcharts.com/docs/v5/
 * ---------------------------------------
 */

// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("chartdiv");


// Set themes
// https://www.amcharts.com/docs/v5/concepts/themes/
root.setThemes([
    am5themes_Animated.new(root)
]);


// Create the map chart
// https://www.amcharts.com/docs/v5/charts/map-chart/
var chart = root.container.children.push(am5map.MapChart.new(root, {
    panX: "rotateX",
    panY: "rotateY",
    projection: am5map.geoOrthographic(),
    paddingBottom: 20,
    paddingTop: 20,
    paddingLeft: 20,
    paddingRight: 20,
    minZoomLevel: 1,
    maxZoomLevel: 1
}));



// Create main polygon series for countries
// https://www.amcharts.com/docs/v5/charts/map-chart/map-polygon-series/
var polygonSeries = chart.series.push(am5map.MapPolygonSeries.new(root, {
    geoJSON: am5geodata_worldLow
}));

polygonSeries.mapPolygons.template.setAll({
    fill: am5.color(0xCEAD77),
    stroke: am5.color(0x2D375B),
    strokeOpacity: 1,
    strokeWidth:1.1,
    tooltipText: "{name}",
    toggleKey: "active",
    interactive: true,
});

var backgroundSeries = chart.series.unshift(
    am5map.MapPolygonSeries.new(root, {})
);

// ocean color
backgroundSeries.mapPolygons.template.setAll({
    fill: am5.color("#323B60"),
    stroke: am5.color("#323B60"),
});

backgroundSeries.data.unshift({
    geometry: am5map.getGeoRectangle(90, 180, -90, -180)
});

polygonSeries.mapPolygons.template.states.create("hover", {
    fill: am5.color(0x323B60),
    stroke: am5.color(0xCEAD77),
    strokeopacity: 1,
    strokeWidth: 1.1
});

polygonSeries.mapPolygons.template.states.create("active", {
    fill: am5.color(0x323B60),
    stroke: am5.color(0xCEAD77),
    strokeopacity: 1,
    strokeWidth: 1.1
});



// polygonSeries.set("fill", am5.color(0xff0000));

// Create series for background fill
// https://www.amcharts.com/docs/v5/charts/map-chart/map-polygon-series/#Background_polygon
var backgroundSeries = chart.series.push(am5map.MapPolygonSeries.new(root, {}));
backgroundSeries.mapPolygons.template.setAll({
    fill: root.interfaceColors.get("alternativeBackground"),
    fillOpacity: 0.1,
    strokeOpacity: 0
});

backgroundSeries.data.push({
    geometry: am5map.getGeoRectangle(90, 180, -90, -180),
    fill: am5.color(0x00FFFF)
});

var graticuleSeries = chart.series.unshift(
    am5map.GraticuleSeries.new(root, {
        step: 10
    })
);

graticuleSeries.mapLines.template.set("strokeOpacity", 0.1)

// Set up events
var previousPolygon;

polygonSeries.mapPolygons.template.on("active", function (active, target) {
    if (previousPolygon && previousPolygon != target) {
        previousPolygon.set("active", false);
    }
    if (target.get("active")) {
        target.fill = am5.color(0xFF0000);
        document.getElementById("ctry-id").innerHTML = target.dataItem.get("id");
        showTours(target.dataItem.get("id"));
        selectCountry(target.dataItem.get("id"));
    }
    previousPolygon = target;
});

function selectCountry(id) {
    var dataItem = polygonSeries.getDataItemById(id);
    var target = dataItem.get("mapPolygon");
    if (target) {
        var centroid = target.geoCentroid();
        if (centroid) {
            chart.animate({ key: "rotationX", to: -centroid.longitude, duration: 1500, easing: am5.ease.inOut(am5.ease.cubic) });
            chart.animate({ key: "rotationY", to: -centroid.latitude, duration: 1500, easing: am5.ease.inOut(am5.ease.cubic) });
        }
    }
}


polygonSeries.events.on("datavalidated", function () {
    selectCountry("IN");
});


// Make stuff animate on load
chart.appear(2000, 100);

function showTours(id) {
    window.location.assign(window.location.origin + "/Tours.aspx?Country=" + id);
}