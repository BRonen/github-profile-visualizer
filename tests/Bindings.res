module ReactTestRenderer = {
  @module("react-test-renderer")
  external create: React.element => Webapi.Dom.Element.t = "create"

  @module("react-test-renderer")
  external act: (unit => unit) => unit = "act"
}

module ReactTestingLibrary = {
  @module("@testing-library/react")
  external render: React.element => unit = "render"

  @module("@testing-library/react")
  external screen: Webapi.Dom.Element.t = "screen"

  @send external getByText: (Webapi.Dom.Element.t, string) => Webapi.Dom.Element.t = "getByText"
  @send external findByText: (Webapi.Dom.Element.t, string) => promise<Webapi.Dom.Element.t> = "findByText"
}

module JsDom = {
  @send
  external toBeInTheDocument: Vitest.expected<Webapi.Dom.Element.t> => unit = "toBeInTheDocument"

  @send
  external toMatchSnapshot: Vitest.expected<Webapi.Dom.Element.t> => unit = "toMatchSnapshot"
}
