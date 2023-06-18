open Vitest
open Setup
open Utils
open ReactTestingLibrary
open ReactTestRenderer
open JsDom

describe("Profile Display component", _ => {
  testAsync("should fetch data and display on the component", async t => {
    t->assertions(4)

    act(() => render(<ProfileDisplay username="johnny" />))

    await sleep(1000)

    screen->getByText("johnny")->expect->toBeInTheDocument
    screen->getByText("100 Followers")->expect->toBeInTheDocument
    screen->getByText("99 Following")->expect->toBeInTheDocument
    screen->getByText("Lorem Ipsum")->expect->toBeInTheDocument
  })

  test("should match component snapshot while loading profile", t => {
    t->assertions(1)

    create(<ProfileDisplay username="johnny" />)->expect->toMatchSnapshot
  })

  testAsync("should match component snapshot after profile loaded", async t => {
    t->assertions(1)

    let profileDisplayComponent = create(<ProfileDisplay username="johnny" />)

    await sleep(1000)

    profileDisplayComponent->expect->toMatchSnapshot
  })
})
