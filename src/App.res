%%raw("import './Globals.css'")

@react.component
let make = () => {
  <ProfileContext.Provider>
    <Header>
      <ProfileSearchInput/>
    </Header>

    <Main>
      <ProfileDisplay/>
    </Main>
  </ProfileContext.Provider>
}
