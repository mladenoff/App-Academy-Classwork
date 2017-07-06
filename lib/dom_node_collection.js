class DOMNodeCollection {
  constructor (array) {
    this.array = array;
  }

  html (string) {
    if (string) {
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
      if (args.instanceof(String)) {
        el.innerHTML.concat(args);
      } else if (args.instanceof(HTMLElement)) {
        el.innerHTML.concat(args.outerHTML);
      } else if (args.instanceof(DOMNodeCollection)) {
        args.forEach((arg) => {
          el.innerHTML.concat(arg.outerHTML);
        });
      }
    });
  }
}

module.exports = DOMNodeCollection;
