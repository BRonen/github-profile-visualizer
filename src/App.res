%%raw("import './Globals.css'")

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  <SearchContext.Provider>
    <Header>
      <SearchInput/>
    </Header>

    <Main>
      {switch url.path {
        | list{"user", username} => <ProfileDisplay username/>
        | list{"search"} => <SearchSuggestionsDisplay/>
        | _ => <Homepage/>
      }}
    </Main>
  </SearchContext.Provider>
}
