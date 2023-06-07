type githubUserProfile = {
    login: string,
    name: option<string>,
    followers: int,
    following: int,
    bio: option<string>,
    htmlUrl: string,
    avatarUrl: string,
}

type githubUserPreview = {
    login: string,
    avatarUrl: string,
}

type githubUserPreviewList = {
    totalCount: int,
    items: array<githubUserPreview>,
}

let baseUrl = "https://api.github.com"

let decodeDictField = (dict, key, decoder) => {
    switch Js.Dict.get(dict, key) {
        | Some(value) => value |> decoder |> Belt.Option.getExn
        | None => Js.Exn.raiseError("Error")
    }
}

let decodeOptionalDictField = (dict, key, decoder) => {
    switch Js.Dict.get(dict, key) {
        | Some(value) => value->decoder
        | None => None
    }
}

let validateUserProfile = (userProfile) => {
    let obj = Js.Json.decodeObject(userProfile)
    
    switch obj {
        | Some(dict) => {
            login: decodeDictField(dict, "login", Js.Json.decodeString),
            name: decodeOptionalDictField(dict, "name", Js.Json.decodeString),
            bio: decodeOptionalDictField(dict, "bio", Js.Json.decodeString),
            followers: decodeDictField(dict, "followers", Js.Json.decodeNumber)->Js.Math.ceil_int,
            following: decodeDictField(dict, "following", Js.Json.decodeNumber)->Js.Math.ceil_int,
            htmlUrl: decodeDictField(dict, "html_url", Js.Json.decodeString),
            avatarUrl: decodeDictField(dict, "avatar_url", Js.Json.decodeString),
        }
        | None => Js.Exn.raiseError("wasdwasd")
    }
}

let validateUserPreview = (userPreview) => {
    let obj = Js.Json.decodeObject(userPreview)

    switch obj {
        | Some(dict) => {
            login: decodeDictField(dict, "login", Js.Json.decodeString),
            avatarUrl: decodeDictField(dict, "avatar_url", Js.Json.decodeString),
        }
        | None => Js.Exn.raiseError("wasdwasdwasdw")
    }
}

let validateUserPreviewList = (userPreviewList) => {
    let obj = Js.Json.decodeObject(userPreviewList)
    
    switch obj {
        | Some(dict) => {
            totalCount: decodeDictField(dict, "total_count", Js.Json.decodeNumber)->Js.Math.ceil_int,
            items: Belt.Array.map(decodeDictField(dict, "items", Js.Json.decodeArray), validateUserPreview),
        }
        | None => Js.Exn.raiseError("wasdwasd")
    }
}

let getUserProfile = async (username) => {
    let response = await Fetch.fetch(`${baseUrl}/users/${username}`)
    let data = await Fetch.Response.json(response)
    validateUserProfile(data)
}

let getUserPreviewList = async (query, page) => {
    let response = await Fetch.fetch(`${baseUrl}/search/users?q=${query}&page=${page}&per_page=10`)
    let data = await Fetch.Response.json(response)
    validateUserPreviewList(data)
}