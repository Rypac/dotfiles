/**
  {
    "api": 1,
    "name": "Join Lines with Spaces",
    "description": "Joins all lines with a space.",
    "author": "Ryan",
    "icon": "collapse",
    "tags": "join,space",
    "bias": 0.1
  }
**/

function main(state) {
  state.text = state.text.replace(/\n/g, ' ')
}
