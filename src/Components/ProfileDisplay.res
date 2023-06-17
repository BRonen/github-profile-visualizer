open GithubService

module Display = {
  @react.component
  let make = (~profile: GithubService.githubUserProfile) => {
    <Row className="gap-5">
      <Picture src={profile.avatarUrl} className="h-60" />
      <div>
        <Title> {profile.login->React.string} </Title>
        <Row className="my-5 gap-5">
          <SubTitle>
            {profile.followers->React.int}
            {" Followers"->React.string}
          </SubTitle>
          <SubTitle>
            {profile.following->React.int}
            {" Following"->React.string}
          </SubTitle>
        </Row>
        {switch profile.bio {
        | Some(bio) => <Description> {bio->React.string} </Description>
        | None => <> </>
        }}
        <Row>
          <a href={profile.htmlUrl}>
            <Icon src="https://api.iconify.design/mdi:github.svg" />
          </a>
        </Row>
      </div>
    </Row>
  }
}

module EmptyDisplay = {
  @react.component
  let make = () => {
    let profilePlaceholder = {
      login: "Any user found",
      name: None,
      followers: 0,
      following: 0,
      bio: None,
      avatarUrl: "https://api.iconify.design/material-symbols:account-circle.svg",
      htmlUrl: "#",
    }

    <Display profile=profilePlaceholder />
  }
}

@react.component
let make = (~username) => {
  let (profilez, setProfile) = React.useState(() => None)
  let (loading, setLoading) = React.useState(() => true)

  let loadProfile = React.useCallback1(async () => {
    let userProfile = await GithubService.getUserProfile(username)

    setProfile(_ => Some(userProfile))
    setLoading(_ => false)
  }, [username])

  React.useEffect1(() => {
    setLoading(_ => true)

    let debounce = setTimeout(() => loadProfile()->ignore, 500)

    Some(_ => clearTimeout(debounce))
  }, [loadProfile])

  switch (loading, profilez) {
  | (true, _) =>
    <div className="h-60 flex items-center justify-center">
      <Loading />
    </div>
  | (false, Some(profile)) => <Display profile />
  | (false, None) => <EmptyDisplay />
  }
}
