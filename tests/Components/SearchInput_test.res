open Vitest
open Setup
open Utils
open ReactTestingLibrary
open ReactTestRenderer
open JsDom

describe("Search input component", _ => {
  testAsync("should clear the pagination and update search query on change", async t => {
    t->assertions(4)

    let value: SearchContext.context = {
      setSearchQuery: %raw(`Vitest$1.vi.fn()`),
      setPage: %raw(`Vitest$1.vi.fn()`),
      searchQuery: "",
      page: 1,
      previews: None,
      setPreviews: _ => (),
      loading: false,
      setLoading: _ => (),
    }

    render(
      <SearchContext.ProviderWrapper value>
        <SearchInput />
      </SearchContext.ProviderWrapper>,
    )

    value.setSearchQuery->expect->toHaveBeenCalledTimesString(0)
    value.setPage->expect->toHaveBeenCalledTimesInt(0)

    let usernameInput = screen->getByPlaceholderText("Username")

    act(
      () => {
        fireEvent.change(. usernameInput, {target: {value: "search text"}})
      },
    )

    await sleep(1000)

    value.setSearchQuery->expect->toHaveBeenCalledTimesString(1)
    value.setPage->expect->toHaveBeenCalledTimesInt(1)
  })

  test("should match component snapshot", t => {
    t->assertions(1)

    create(<SearchInput />)->expect->toMatchSnapshot
  })
})
