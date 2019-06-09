import React, { Component } from "react";
import {
  BrowserRouter as Router,
  Switch,
  Redirect,
  Route
} from "react-router-dom";

import WelcomePage from "./pages/WelcomePages";
import RegisterPage from "./pages/RegisterPage";

class Root extends Component {
  render() {
    return (
      <Router>
        <Switch>
          <Route path="/welcome" component={WelcomePage} />
          <Route path="/register" component={RegisterPage} />
          <Redirect to="/welcome" />
        </Switch>
      </Router>
    );
  }
}

export default Root;
