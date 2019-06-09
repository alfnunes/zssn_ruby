import React, { Component } from "react";
import * as api from "../../api";
import { Link } from "react-router-dom";
import PublicLayout from "../../containers/PublicLayout";

export default class WelcomePage extends Component {
  state = {
    survivors: []
  };

  fetchSurvivors = () => {
    api.getSurvivors().then(({ data }) => {
      const survivors = data.map(survivor => ({
        ...survivor
      }));

      this.setState(() => ({
        survivors
      }));
    });
  };

  componentDidMount = () => {
    this.fetchSurvivors();
  };

  render() {
    const { survivors } = this.state;
    return (
      <section>
        <h1>Bem vindo ao ZSSN!</h1>
        <div style={{ marginBottom: "1rem" }}>
          {survivors.map(survivor => (
            <p
              style={{
                marginLeft: "20px",
                color: survivor.infected === true ? "red" : "black"
              }}
            >
              <span>
                <b>Nome:</b> {survivor.name}
              </span>
              <span style={{ marginLeft: "20px" }}>
                <b>Sexo:</b> {survivor.gender}
              </span>
              <span style={{ marginLeft: "20px" }}>
                <b>Infectado:</b> {survivor.infected === true ? "Sim" : "Não"}
              </span>
              <span style={{ marginLeft: "20px" }}>
                <b>Position:</b> Latitude: {survivor.last_location.x},
                Longitude: {survivor.last_location.y}
              </span>
            </p>
          ))}
        </div>
        <PublicLayout.Footer>
          <Link to="/register" className="ui big button">
            <b>Novo Sobrevivente</b>
          </Link>
        </PublicLayout.Footer>
      </section>
    );
  }
}
