/**
  {
    "api": 1,
    "name": "Join Lines with Commas",
    "description": "Joins all lines with a comma.",
    "author": "Ryan",
    "icon": "collapse",
    "tags": "join,comma",
    "bias": 0.1
  }
**/

function main(state) {
  state.text = state.text.replace(/\n/g, ',')
}
