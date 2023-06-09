open Vitest
open Bindings
open ReactTestingLibrary
open ReactTestRenderer
open JsDom

describe("Homepage component", _ => {
  beforeEach(() => {
    render(<Homepage />)
  })

  test("should match compoenent snapshot", (t) => {
    t->assertions(1)

    create(<Homepage/>)->expect->toMatchSnapshot
  })
})
