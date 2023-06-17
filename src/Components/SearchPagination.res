module PaginationButton = {
  @react.component
  let make = (~page) => {
    let context = React.useContext(SearchContext.context)

    let extraClass = context.page == page ? "bg-stone-100" : ""

    <button
      className={`rounded-full border shadow px-3 py-1 aspect-square ${extraClass} hover:bg-stone-200`}
      onClick={_ => context.setPage(_ => page)}>
      {page->React.int}
    </button>
  }
}

@react.component
let make = () => {
  let context = React.useContext(SearchContext.context)

  switch context.previews {
  | Some(previews) => {
      let pagesCount = (previews.totalCount->Int.toFloat /. 10.0)->Math.ceil->Float.toInt

      <Row className="mt-3 gap-3 justify-end">
        <button
          className={`rounded-full border shadow px-3 py-1 aspect-square ${context.page == 1
              ? "bg-stone-100"
              : ""} hover:bg-stone-200`}
          onClick={_ => context.setPage(page => page - 1)}
          disabled={context.page == 1}>
          <img
            src="https://api.iconify.design/material-symbols:arrow-back.svg"
            className="h-4"
            alt="back arrow pagination button"
          />
        </button>
        <span
          className="grid place-items-center w-10 rounded-full border shadow px-3 py-1 aspect-square text-lg">
          {context.page->React.int}
        </span>
        <button
          className={`rounded-full border shadow px-3 py-1 aspect-square ${context.page ==
              pagesCount
              ? "bg-stone-100"
              : ""} hover:bg-stone-200`}
          onClick={_ => context.setPage(page => page + 1)}
          disabled={context.page == pagesCount}>
          <img
            src="https://api.iconify.design/material-symbols:arrow-forward.svg"
            className="h-4"
            alt="back arrow pagination button"
          />
        </button>
      </Row>
    }
  | None => <> </>
  }
}
