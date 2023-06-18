open Vitest
open GithubApi_mock

%%raw(`import '@testing-library/jest-dom'`)

@module("vitest") external afterAll: (@uncurry (unit => unit)) => unit = "afterAll"

module ReactTestRenderer = {
  @module("react-test-renderer")
  external create: React.element => Webapi.Dom.Element.t = "create"

  @module("react-test-renderer")
  external act: (unit => unit) => unit = "act"
}

module ReactTestingLibrary = {
  type target = {value: string}
  type event = {target: target}
  type fireEvent = {change: (. Webapi.Dom.Element.t, event) => unit}

  @module("@testing-library/react")
  external fireEvent: fireEvent = "fireEvent"

  @module("@testing-library/react")
  external render: React.element => unit = "render"

  @module("@testing-library/react")
  external screen: Webapi.Dom.Element.t = "screen"

  @send external getByText: (Webapi.Dom.Element.t, string) => Webapi.Dom.Element.t = "getByText"
  @send
  external getByPlaceholderText: (Webapi.Dom.Element.t, string) => Webapi.Dom.Element.t =
    "getByPlaceholderText"
  @send
  external findByText: (Webapi.Dom.Element.t, string) => promise<Webapi.Dom.Element.t> =
    "findByText"
}

module JsDom = {
  @send
  external toBeInTheDocument: Vitest.expected<Webapi.Dom.Element.t> => unit = "toBeInTheDocument"

  @send
  external toMatchSnapshot: Vitest.expected<Webapi.Dom.Element.t> => unit = "toMatchSnapshot"

  @send
  external toHaveBeenCalledTimesInt: (Vitest.expected<(int => int) => unit>, int) => unit =
    "toHaveBeenCalledTimes"

  @send
  external toHaveBeenCalledTimesString: (Vitest.expected<(string => string) => unit>, int) => unit =
    "toHaveBeenCalledTimes"
}

beforeAll(() => {
  server.listen(. {onUnhandledRequest: "error"})
})

afterAll(() => {
  server.close(.)
})

afterEach(() => {
  server.resetHandlers(.)
})
