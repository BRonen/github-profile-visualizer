open Vitest
open Setup
open ReactTestRenderer
open JsDom
open GithubService

describe("Search suggestion preview card component", _ => {
  test("should match component snapshot", t => {
    t->assertions(1)

    let item = {
      login: "johnny",
      avatarUrl: "#avatarUrl",
    }

    create(<SearchSuggestionsDisplay.UserPreview item />)->expect->toMatchSnapshot
  })
})
