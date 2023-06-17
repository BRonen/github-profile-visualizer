open Vitest
open Setup
open ReactTestingLibrary
open ReactTestRenderer
open JsDom

describe("Profile Display component", _ => {
  test("should fetch data and display on the component", t => {
    t->assertions(1)

    let value: SearchContext_mock.context = {
      setSearchQuery: %raw(`Vitest$1.vi.fn()`),
      setPage: %raw(`Vitest$1.vi.fn()`),
    }

    act(
      () =>
        render(
          <SearchContext_mock.Provider value>
            <SearchInput />
          </SearchContext_mock.Provider>,
        ),
    )

    value.setSearchQuery->expect->toHaveBeenCalledTimes(0)
  })

  test("should match component snapshot", t => {
    t->assertions(1)

    create(<SearchInput />)->expect->toMatchSnapshot
  })
})
