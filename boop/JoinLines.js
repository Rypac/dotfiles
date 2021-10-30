/**
  {
    "api": 1,
    "name": "Join Lines",
    "description": "Joins all lines without any delimiter.",
    "author": "Ryan",
    "icon": "collapse",
    "tags": "join"
  }
**/

function main(state) {
  state.text = state.text.replace(/\n/g, '')
}
