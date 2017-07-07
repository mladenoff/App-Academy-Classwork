const DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function(selector) {
  if (selector instanceof (HTMLElement)) {
    return new DOMNodeCollection(Array.from(selector));
  } else if (typeof selector === 'string') {
    let elementList = Array.from(document.querySelectorAll(selector));
    return new DOMNodeCollection(elementList);
  }
};
