import React, { Component } from "react";
import * as api from "../../api";

export default class RegisterPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      age: 0,
      gender: "",
      lat: "",
      lng: "",
      ammunition: 0,
      medication: 0,
      food: 0,
      water: 0,
      resourcesFromApi: []
    };

    this.handleName = this.handleName.bind(this);
    this.handleAge = this.handleAge.bind(this);
    this.handleGender = this.handleGender.bind(this);
    this.handleLatitude = this.handleLatitude.bind(this);
    this.handleLongitude = this.handleLongitude.bind(this);
    this.handleAmmunition = this.handleAmmunition.bind(this);
    this.handleMedication = this.handleMedication.bind(this);
    this.handleFood = this.handleFood.bind(this);
    this.handleWater = this.handleWater.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleName(event) {
    this.setState({ name: event.target.value });
  }

  handleAge(event) {
    this.setState({ age: event.target.value });
  }

  handleGender(event) {
    this.setState({ gender: event.target.value });
  }

  handleLatitude(event) {
    this.setState({ lat: event.target.value });
  }

  handleLongitude(event) {
    this.setState({ lng: event.target.value });
  }

  handleAmmunition(event) {
    this.setState({ ammunition: event.target.value });
  }

  handleMedication(event) {
    this.setState({ medication: event.target.value });
  }

  handleFood(event) {
    this.setState({ food: event.target.value });
  }

  handleWater(event) {
    this.setState({ water: event.target.value });
  }

  handleSubmit(event) {
    const name = this.state.name;
    const age = this.state.age;
    const gender = this.state.gender;
    const latitude = this.state.lat;
    const longitude = this.state.lng;
    const resources = [];

    if (this.state.ammunition > 0) {
      resources.push({
        resource_id: this.state.resourcesFromApi.find(
          f => f.name === "Ammunition"
        ).id,
        amount: this.state.ammunition
      });
    }

    if (this.state.medication > 0) {
      resources.push({
        resource_id: this.state.resourcesFromApi.find(
          f => f.name === "Medication"
        ).id,
        amount: this.state.medication
      });
    }

    if (this.state.food > 0) {
      resources.push({
        resource_id: this.state.resourcesFromApi.find(f => f.name === "Food")
          .id,
        amount: this.state.food
      });
    }

    if (this.state.water > 0) {
      resources.push({
        resource_id: this.state.resourcesFromApi.find(f => f.name === "Water")
          .id,
        amount: this.state.water
      });
    }
    api
      .createSurvivor(name, age, gender, latitude, longitude, resources)
      .then(({ data }) => {
        console.log(data);
      });
    event.preventDefault();
  }

  fetchResources = () => {
    api.getResources().then(({ data }) => {
      const resources = data.map(resource => ({
        ...resource
      }));

      this.setState(() => ({
        resourcesFromApi: resources
      }));
    });
  };

  componentDidMount = () => {
    this.fetchResources();
  };

  render() {
    return (
      <section>
        <h1>Novo Sobrevivente</h1>
        <form onSubmit={this.handleSubmit}>
          <p style={{ marginLeft: "10px" }}>
            <label>
              Nome:
              <input
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.name}
                onChange={this.handleName}
              />
            </label>
            <label style={{ marginLeft: "5px" }}>
              Idade:
              <input
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.age}
                onChange={this.handleAge}
              />
            </label>
            <label style={{ marginLeft: "5px" }}>
              Sexo:
              <input
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.gender}
                onChange={this.handleGender}
              />
            </label>
            <label style={{ marginLeft: "5px" }}>
              Posição:
              <input
                placeholder="Latitude"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.lat}
                onChange={this.handleLatitude}
              />
              <input
                placeholder="Longitude"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.lng}
                onChange={this.handleLongitude}
              />
            </label>
          </p>
          <p style={{ marginLeft: "10px" }}>
            <label> Recursos: </label> <br />
            <label>
              Munição:
              <input
                placeholder="Quantidade"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.ammunition}
                onChange={this.handleAmmunition}
              />
            </label>
            <br />
            <label>
              Medicamento:
              <input
                placeholder="Quantidade"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.medication}
                onChange={this.handleMedication}
              />
            </label>
            <br />
            <label>
              Comida:
              <input
                placeholder="Quantidade"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.food}
                onChange={this.handleFood}
              />
            </label>
            <br />
            <label>
              Água:
              <input
                placeholder="Quantidade"
                style={{ marginLeft: "3px" }}
                type="text"
                value={this.state.water}
                onChange={this.handleWater}
              />
            </label>
          </p>
          <input type="submit" value="Submit" />
        </form>
      </section>
    );
  }
}
