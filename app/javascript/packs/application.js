import "bootstrap";
import { ticker } from '../plugins/stocks';
const feed = document.querySelector('.pages.feed');
if (feed) {
ticker();
}
// import Chartkick from "chartkick";
// window.Chartkick = Chartkick;

// // for Chart.js
// import Chart from "chart.js";
// Chartkick.addAdapter(Chart);

// // for Highcharts
// import Highcharts from "highcharts";
// Chartkick.addAdapter(Highcharts);



// for Google Charts
// just include https://www.gstatic.com/charts/loader.js in your views

