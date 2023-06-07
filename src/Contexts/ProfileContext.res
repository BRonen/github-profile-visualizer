type context = {
  profile: option<GithubService.githubUser>,
  searchQuery: string,
  setProfile: (option<GithubService.githubUser> => option<GithubService.githubUser>) => unit,
  setSearchQuery: (string => string) => unit,
  loading: bool,
  setLoading: (bool => bool) => unit,
}

let context = React.createContext({
  profile: None,
  setProfile: _ => (),
  searchQuery: "",
  setSearchQuery: _ => (),
  loading: false,
  setLoading: _ => (),
})

module ProviderWrapper = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children: React.element) => {
    let (searchQuery, setSearchQuery) = React.useState(() => "")
    let (profile, setProfile) = React.useState(() => None)
    let (loading, setLoading) = React.useState(() => false)

    let value = {
      profile, setProfile,
      searchQuery, setSearchQuery,
      loading, setLoading,
    }

    let loadProfile = React.useCallback1(async () => {
      try{
        if(searchQuery == "") { Js.Exn.raiseError("") }
        setLoading(_ => true)
        let userProfile = await GithubService.getUserProfile(searchQuery)
        setProfile((_) => Some(userProfile))
      } catch {
        | _ => setProfile((_) => None)
      }
      setLoading(_ => false)
    }, [searchQuery])

    React.useEffect1(() => {
        let debounce = setTimeout(() => loadProfile()->ignore, 500)
        Some(() => clearTimeout(debounce))
    }, [loadProfile])

    <ProviderWrapper value>
      children
    </ProviderWrapper>
  }
}