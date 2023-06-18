open Vitest
open Setup
open ReactTestingLibrary
open JsDom

describe("App Component", _ => {
  test("should render homepage component", _ => {
    render(<App />)

    screen->getByText("Github Profile Search")->expect->toBeInTheDocument
  })
})
