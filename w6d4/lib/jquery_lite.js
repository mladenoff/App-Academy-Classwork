/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

window.$l = function(selector) {
  if (selector instanceof (HTMLElement)) {
    return new DOMNodeCollection(Array.from(selector));
  } else if (typeof selector === 'string') {
    let elementList = Array.from(document.querySelectorAll(selector));
    return new DOMNodeCollection(elementList);
  }
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor (array) {
    this.array = array;
  }

  html (string) {
    if (typeof string === 'string') {
      this.array.forEach((el) => {
        el.innerHTML = string;
      });
    } else {
      return this.array[0].innerHTML;
    }
  }

  empty () {
    this.html("");
  }

  append (args) {
    this.array.forEach((el) => {
      if (typeof args === 'string') {
        el.innerHTML += (args);
      } else if (args instanceof (HTMLElement)) {
        el.innerHTML += args.outerHTML;
      } else if (args instanceof (DOMNodeCollection)) {
        args.forEach((arg) => {
          el.innerHTML += arg.outerHTML;
        });
      }
    });
  }

  attr(attribute, value) {
    if (typeof value !== 'string' && !value) {
      return this.array[0].getAttribute(attribute);
    } else {
      this.array.forEach((el) => {
        el.setAttribute(attribute,value);
      });
    }
  }

  addClass(className){
    this.attr('class',className);
  }

  removeClass(className) {
    if (typeof className === 'string') {
      let classNames = className.split(" ");
      this.array.forEach((el) => {
        if (el.getAttribute('class')) {let elClasses = el.getAttribute('class').split(" ");
        let tempClasses = [];
        elClasses.forEach((elClass) => {
          if (!classNames.includes(elClass)) {
            tempClasses.push(elClass);
          }
        });
        el.setAttribute('class', tempClasses.join(" "));}
      });
    } else {
      this.array.forEach((el) => {
        el.setAttribute('class', "");
      });
    }
  }

  children(){
    let results = [];
    this.array.forEach ((el) => {
      results = results.concat(Array.from(el.children));
    });
    return new DOMNodeCollection(results);
  }

  parent(){
    let results = [];
    this.array.forEach ((el) => {
      results.push(el.parentNode);
    });
    let uniqResults = [];
    results.forEach ((result) => {
      if (!uniqResults.includes(result)) {
        uniqResults.push(result);
      }
    });
    return new DOMNodeCollection(uniqResults);
  }
  find(selector) {
    let results = [];
    this.array.forEach((el) => {
      results = results.concat(Array.from(el.querySelectorAll(selector)));
    });
    return new DOMNodeCollection(results);
  }
  remove() {
    this.array.forEach((el) => {
      el.outerHTML = "";
    });
    this.array = [];
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);