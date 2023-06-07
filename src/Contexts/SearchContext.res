type context = {
  previews: option<GithubService.githubUserPreviewList>,
  setPreviews: (option<GithubService.githubUserPreviewList> => option<GithubService.githubUserPreviewList>) => unit,
  searchQuery: string,
  setSearchQuery: (string => string) => unit,
  loading: bool,
  setLoading: (bool => bool) => unit,
  page: int,
  setPage: (int => int) => unit
}

let context = React.createContext({
  previews: None,
  setPreviews: _ => (),
  searchQuery: "",
  setSearchQuery: _ => (),
  loading: false,
  setLoading: _ => (),
  page: 1,
  setPage: _ => (),
})

module ProviderWrapper = {
  let make = React.Context.provider(context)
}

let captureQueryParam = () => {
  let url = RescriptReactRouter.dangerouslyGetInitialUrl()
  let pattern = %re("/(?<=q=)[a-zA-Z0-9]+/g")
  switch Js.Re.exec_(pattern, url.search) {
    | Some(queryResults) => {
      let results = Js.Re.captures(queryResults)
      switch results->Js.Array2.shift {
        | Some(result) => result->Js.Nullable.toOption->Belt.Option.getExn
        | None => ""
      }
    }
    | None => ""
  }
}

module Provider = {
  @react.component
  let make = (~children: React.element) => {
    let initialSearchQuery = captureQueryParam()
    let (searchQuery, setSearchQuery) = React.useState(() => initialSearchQuery)
    let (previews, setPreviews) = React.useState(() => None)
    let (loading, setLoading) = React.useState(() => initialSearchQuery !== ""? true : false)
    let (page, setPage) = React.useState(() => 1)

    let value = {
      previews, setPreviews,
      searchQuery, setSearchQuery,
      loading, setLoading,
      page, setPage,
    }

    let loadSuggestions = React.useCallback1(async () => {
      try{
        if(searchQuery == "") { Js.Exn.raiseError("") }

        setLoading(_ => true)

        let userPreviews = await GithubService.getUserPreviewList(searchQuery, page->Js.Int.toString)

        setPreviews((_) => Some(userPreviews))
        RescriptReactRouter.push(`/?q=${searchQuery}`)
      } catch {
        | _ => setPreviews((_) => None)
      }

      setLoading(_ => false)
    }, [searchQuery, page->Js.Int.toString])

    React.useEffect1(() => {
        let debounce = setTimeout(() => loadSuggestions()->ignore, 500)
        Some(() => clearTimeout(debounce))
    }, [loadSuggestions])

    <ProviderWrapper value>
      children
    </ProviderWrapper>
  }
}