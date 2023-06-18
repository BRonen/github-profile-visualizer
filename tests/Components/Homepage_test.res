open Vitest
open Setup
open ReactTestRenderer
open JsDom

describe("Homepage component", _ => {
  test("should match compoenent snapshot", t => {
    t->assertions(1)

    create(<Homepage />)->expect->toMatchSnapshot
  })
})
