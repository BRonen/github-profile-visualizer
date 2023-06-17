open SearchContext

@react.component
let make = () => {
  let context = React.useContext(SearchContext.context)

  let onChange = e => {
    ReactEvent.Form.preventDefault(e)
    let value = ReactEvent.Form.target(e)["value"]

    context.setPage(_ => 1)
    context.setSearchQuery(_ => value)
  }

  <input
    onChange
    value={context.searchQuery}
    placeholder="Username"
    className="rounded-md h-8 w-full mx-96 px-2 py-1 border shadow-sm focus:shadow-md transition-all focus:outline-none"
    style={{
      backgroundColor: "#fff",
      backgroundImage: "url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBmaWxsPSJncmF5IiBkPSJNMTUuNSAxNGgtLjc5bC0uMjgtLjI3QTYuNDcxIDYuNDcxIDAgMCAwIDE2IDkuNUE2LjUgNi41IDAgMSAwIDkuNSAxNmMxLjYxIDAgMy4wOS0uNTkgNC4yMy0xLjU3bC4yNy4yOHYuNzlsNSA0Ljk5TDIwLjQ5IDE5bC00Ljk5LTV6bS02IDBDNy4wMSAxNCA1IDExLjk5IDUgOS41UzcuMDEgNSA5LjUgNVMxNCA3LjAxIDE0IDkuNVMxMS45OSAxNCA5LjUgMTR6Ii8+PC9zdmc+)",
      backgroundPosition: "right .5rem center",
      backgroundSize: "22px",
      backgroundRepeat: "no-repeat",
    }}
  />
}
