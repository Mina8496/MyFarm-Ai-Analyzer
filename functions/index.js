const functions = require("firebase-functions");
const axios = require("axios");

const API_KEY = functions.config().paymob?.api_key;

exports.paymobAuth = functions.https.onRequest(async (req, res) => {
  try {
    const response = await axios.post(
      "https://accept.paymob.com/api/auth/tokens",
      {
        api_key: API_KEY,
      }
    );

    return res.status(200).send(response.data);
  } catch (error) {
    return res.status(500).send(error.toString());
  }
});