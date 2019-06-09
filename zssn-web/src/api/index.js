import axios from "axios";
import { API_URL } from "../utils/constants";

export const getSurvivors = () => axios.get(`${API_URL}/api/v1/survivors`);

export const getSurvivorById = personId =>
  axios.get(`${API_URL}/api/v1/survivors/${personId}`);

export const getResources = () => axios.get(`${API_URL}/api/v1/resources`);

export const createSurvivor = (name, age, gender, lat, long, resources) => {
  const person = {
    name: name,
    age: age,
    gender: gender,
    latitude: lat,
    longitude: long,
    resources: resources
  };

  return axios.post(`${API_URL}/api/v1/survivors`, person);
};
