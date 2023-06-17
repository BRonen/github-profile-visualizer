type context = {
  setSearchQuery: (string => string) => unit,
  setPage: (int => int) => unit,
}

let context = React.createContext({
  setSearchQuery: _ => (),
  setPage: _ => (),
})

module Provider = {
  let make = React.Context.provider(context)
}
