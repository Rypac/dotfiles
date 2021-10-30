/**
  {
    "api": 1,
    "name": "New Boop Script",
    "description": "Returns a basic Boop script.",
    "author": "Ryan",
    "icon": "quote",
    "tags": "boop,state,script,debug,new,create"
  }
**/

function main(state) {
    state.text =
`/**
  {
    "api": 1,
    "name": "New Boop Script",
    "description": "What does your script do?",
    "author": "Ryan",
    "icon": "broom",
    "tags": "place,tags,here",
    "bias": 0.0
  }
**/

function main(state) {
  try {
    /*
    The 'state' object has three properties to deal with text: text, fullText, and selection.
    state.fullText will contain or set the entire string from the Boop editor, regardless of whether a selection is made or not.
    state.selection will contain or set the currently selected text, one at a time if more that one selection exists.
    state.text will behave like selection if there is one or more selected piece of text, otherwise it will behave like fullText.
    */
    state.fullText = state.selection // Remove all but selected text
  }
  catch(error) {
    state.postError("Explain what went wrong here…")
  }
}
`
}
