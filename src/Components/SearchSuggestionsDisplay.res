open GithubService

module UserPreview = {
  @react.component
  let make = (~item: githubUserPreview) => {
    <a onClick={_ => RescriptReactRouter.push(`/user/${item.login}`)}>
      <Row
        className="items-center gap-3 h-40 p-3 bg-gray-100 shadow-md cursor-pointer hover:scale-[1.02] transition-transform">
        <Picture src={item.avatarUrl} className="h-32" />
        <SubTitle> {item.login->React.string} </SubTitle>
      </Row>
    </a>
  }
}

@react.component
let make = () => {
  let context = React.useContext(SearchContext.context)

  switch (context.loading, context.previews) {
  | (true, _) => <Loading />
  | (false, Some(previews)) =>
    <>
      <Title className="mb-8">
        {`Found a total of ${previews.totalCount->Int.toString} results`->React.string}
      </Title>
      <div className="grid grid-cols-1 lg:grid-cols-2 justify-center gap-4">
        {Belt.Array.map(previews.items, item => <UserPreview item key={item.login} />)->React.array}
      </div>
      <SearchPagination />
    </>
  | (false, None) => <Title> {"Any user found"->React.string} </Title>
  }
}
