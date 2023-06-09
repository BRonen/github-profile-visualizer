open Vitest
open Bindings
open ReactTestingLibrary
open ReactTestRenderer
open JsDom

let sleep = ms => {
  Js.Promise2.make((~resolve, ~reject) => {
    setTimeout(() => resolve(. ()), ms)->ignore
    ()
  })
}

type createFetchResponse = {json: unit => Js.Promise.t<string>}
let createFetchResponse: string => createFetchResponse = data => {
  {
    json: () =>
      Js.Promise2.make((~resolve, ~reject) => {
        resolve(. data)
      }),
  }
}

describe("Profile Display component", _ => {
  beforeAll(() => {
    %raw(`
        global.fetch = () => {
            return {
                json: Vitest$1.vi.fn(
                    () => ({
                        login: "johnny",
                        name: "John Doe",
                        followers: 100,
                        following: 99,
                        bio: "Lorem Ipsum",
                        html_url: "#htmlUrl",
                        avatar_url: "#avatarUrl",
                    })
                )
            }
        }
    `)
  })

  test("should match component snapshot", t => {
    t->assertions(1)

    create(<ProfileDisplay username="johnny" />)->expect->toMatchSnapshot
  })

  testAsync("should match component snapshot", async t => {
    t->assertions(1)

    act(() => render(<ProfileDisplay username="johnny" />))

    await sleep(1000)

    screen->getByText("Lorem Ipsum")->expect->toBeInTheDocument

    /*
    TODO: Create a way to mock globals
    %raw(`
        expect(fetch().json).toHaveBeenCalledTimes(1)
    `)
    */
  })
})
