import React from 'react';

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = { time: new Date() };
    this.tickID = 0;
  }

  componentDidMount() {
    this.tickID = setInterval(this.tick.bind(this), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.tickID);
  }


  tick() {
    this.setState({time: new Date()});
  }

  render() {
    let time = this.state.time;
    // let options = {month: 'long'};
    return(

      <div>
        <h1>Clock</h1>
        <div className="clockBox">
        <h2>Time: {time.toLocaleTimeString()}</h2>
        <h2>Date: {time.toLocaleDateString('en-US', {weekday: 'long', month: 'long', day: 'numeric', year: 'numeric'})}</h2>
        </div>
    </div>


    );
  }
}


export default Clock;
