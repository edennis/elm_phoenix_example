const Elm = require("./elm-build/elm.js");

const elmContainer = document.querySelector("#elm-container");

Elm.Main.embed(elmContainer);
