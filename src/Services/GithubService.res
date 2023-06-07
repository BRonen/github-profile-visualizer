type githubUser = {
    name: string,
    followers: int,
    following: int,
    bio: string,
    htmlUrl: string,
    avatarUrl: string,
}

let baseUrl = "https://api.github.com"

let decodeDictField = (dict, key, decoder) => {
    switch Js.Dict.get(dict, key) {
        | Some(value) => value |> decoder |> Belt.Option.getExn
        | None => Js.Exn.raiseError("Error")
    }
}

let validateUserProfile = (userProfile) => {
    let obj = Js.Json.decodeObject(userProfile)
    
    switch obj {
        | Some(dict) => {
            name: decodeDictField(dict, "name", Js.Json.decodeString),
            bio: decodeDictField(dict, "bio", Js.Json.decodeString),
            followers: Js.Math.ceil_int(decodeDictField(dict, "followers", Js.Json.decodeNumber)),
            following: Js.Math.ceil_int(decodeDictField(dict, "following", Js.Json.decodeNumber)),
            htmlUrl: decodeDictField(dict, "html_url", Js.Json.decodeString),
            avatarUrl: decodeDictField(dict, "avatar_url", Js.Json.decodeString),
        }
        | None => Js.Exn.raiseError("wasdwasd")
    }
}

let getUserProfile = async (profileName: string) => {
    let response = await Fetch.fetch(`${baseUrl}/users/${profileName}`)
    let data = await Fetch.Response.json(response)
    validateUserProfile(data)
}