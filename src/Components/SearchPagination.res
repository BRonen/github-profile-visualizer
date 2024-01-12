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

let getPaginationButtonsNumbers = (currentPage, totalPagesCount) => {
  if totalPagesCount == 1 {
    [1]
  } else if totalPagesCount == 2 {
    [1, 2]
  } else if currentPage == 1 || currentPage == 2 {
    [1, 2, 3]
  } else if currentPage >= 3 && currentPage < totalPagesCount {
    [currentPage - 1, currentPage, currentPage + 1]
  } else {
    [currentPage - 2, currentPage - 1, currentPage]
  }
}

@react.component
let make = () => {
  let context = React.useContext(SearchContext.context)

  switch context.previews {
  | Some(previews) => {
      let pagesCount = (previews.totalCount->Int.toFloat /. 10.0)->Math.ceil->Float.toInt

      let pageButtons: array<int> = getPaginationButtonsNumbers(context.page, pagesCount)

      <Row className="mt-3 gap-3 justify-end">
        {Belt.Array.map(pageButtons, pageButton =>
          <PaginationButton page={pageButton} />
        )->React.array}
      </Row>
    }
  | None => <> </>
  }
}
