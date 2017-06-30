class Clock {
  constructor() {
    // 1. Create a Date object.
    let date = new Date();
    // Date.prototype.setTime()
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    // 2. Store the hours, minutes, and seconds.
    this.printTime();
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    let that = this;

    // setInterval( () => {that._tick();},1000);
    setInterval(that._tick.bind(this),1000);
  }

  printTime() {

    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
    // Format the time in HH:MM:SS
    // Use console.log to print it.
  }

  _tick () {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    // that.seconds = date.getSeconds();
    this.seconds++;
    if (this.seconds > 59){
      this.minutes += 1;
      this.seconds = 0;
    }

    if (this.minutes > 59){
      this.hours += 1;
      this.minutes = 0;
    }

    this.printTime();
  }
}

const clock = new Clock();
