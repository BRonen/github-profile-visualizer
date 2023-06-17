open GithubService

type githubUserProfileResponse = {
  login: string,
  name: option<string>,
  followers: int,
  following: int,
  bio: option<string>,
  html_url: string,
  avatar_url: string,
}
let githubUserProfile: githubUserProfileResponse = {
  login: "johnny",
  name: Some("John Doe"),
  followers: 100,
  following: 99,
  bio: Some("Lorem Ipsum"),
  html_url: "#htmlUrl",
  avatar_url: "#avatarUrl",
}

module Msw = {
  type mswHandler

  type serverListenParams = {onUnhandledRequest: string}

  type server = {
    listen: (. serverListenParams) => unit,
    close: (. unit) => unit,
    resetHandlers: (. unit) => unit,
  }

  @module("msw/node")
  external setupServerInternal: unknown => server = "setupServer"

  let setupServer: array<mswHandler> => server = handlers => {
    handlers->ignore
    setupServerInternal(%raw(`...handlers`))
  }

  type rest

  @module("msw")
  external rest: rest = "rest"

  type responseParam = (. unknown, unknown) => unknown

  type mswCtx = {
    status: (. int) => unknown,
    json: (. githubUserProfileResponse) => unknown,
  }

  @send
  external get: (rest, string, (. unit, responseParam, mswCtx) => unknown) => mswHandler = "get"
}

let server = Msw.setupServer([
  Msw.rest->Msw.get(baseUrl ++ "/users/johnny", (. _, res, ctx) => {
    res(. ctx.status(. 200), ctx.json(. githubUserProfile))
  }),
])
