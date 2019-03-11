import "bootstrap";
import { ticker } from '../plugins/stocks';
const feed = document.querySelector('.pages.feed');
if (feed) {
ticker();
}
