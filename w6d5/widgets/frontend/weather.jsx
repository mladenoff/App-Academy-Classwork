import React from 'react';

class Weather extends React.Component {
  constructor(){
    super();

    this.state = {weather: {}, cityName: {}};
    // this.fetchWeather();
  }

  fetchWeather(lat, lon) {
    const APIKEY = "89f070b9215f29d7ece42590a3d18456";
    var request = new XMLHttpRequest();
    // request.open('GET', '/my/url', true);
    //
    // request.onload = function() {
    //   if (request.status >= 200 && request.status < 400) {
    //     // Success!
    //     var resp = request.responseText;
    //   } else {
    //     // We reached our target server, but it returned an error
    //
    //   }
    // };
    //
    // request.onerror = function() {
    //   // There was a connection error of some sort
    // };
    //
    // request.send();

    $.ajax({
      method: "GET",
      url: `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&APPID=${APIKEY}`,
    }).then((response) => {
      this.setState({weather: response.main});
      this.setState({cityName: response.name});
      });
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition((position) => {
      this.fetchWeather(position.coords.latitude, position.coords.longitude);
    });
  }

  render() {
    return (
      <div>
        <h2>Weather</h2>
        <div>
          <h2>{this.state.weather.temp}</h2>
          <h2>{this.state.cityName}</h2>
        </div>
      </div>
    );
  }
}


export default Weather;
