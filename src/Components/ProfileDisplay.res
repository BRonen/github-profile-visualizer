open GithubService

module Display = {
    @react.component
    let make = (~profile) => {
        
        <Row className="gap-5">
            <Picture src={profile.avatarUrl}/>
            <div>
                <Title>{profile.name->React.string}</Title>
                <Row className="mt-5 gap-5">
                    <SubTitle>
                        {profile.followers->React.int}
                        {" Followers"->React.string}
                    </SubTitle>
                    <SubTitle>
                        {profile.following->React.int}
                        {" Following"->React.string}
                    </SubTitle>
                </Row>
                <Description className="mt-5">{profile.bio->React.string}</Description>
                <Row>
                    <a href={profile.htmlUrl}>
                        <Icon src="https://api.iconify.design/mdi:github.svg"/>
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
            name: "Any user found",
            followers: 0,
            following: 0,
            bio: "",
            avatarUrl: "https://api.iconify.design/material-symbols:account-circle.svg",
            htmlUrl: "#",
        }

        <Display profile=profilePlaceholder/>
    }
}

@react.component
let make = () => {
    let context = React.useContext(ProfileContext.context)

    switch (context.loading, context.profile) {
        | (true, _) => <div className="h-60 flex items-center justify-center"><Loading/></div>
        | (false, Some(profile)) => <Display profile />
        | (false, None) => <EmptyDisplay />
    }
}