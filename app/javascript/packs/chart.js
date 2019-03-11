import Chartkick from "chartkick";
window.Chartkick = Chartkick;

// for Chart.js
import Chart from "chart.js";
Chartkick.addAdapter(Chart);

// for Highcharts
import Highcharts from "highcharts";
Chartkick.addAdapter(Highcharts);


