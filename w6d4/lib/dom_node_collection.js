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
