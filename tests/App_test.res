open Vitest
open Bindings
open ReactTestingLibrary
open JsDom

describe("App Component", _ => {
  beforeEach(() => {
    render(<App />)
  })

  test("should render homepage component", (_) => {
    screen->getByText("Github Profile Search")->expect->toBeInTheDocument
  })
})
