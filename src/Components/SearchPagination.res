module PaginationButton = {
    @react.component
    let make = (~page) => {
        let context = React.useContext(SearchContext.context)

        let extraClass = context.page == page? "bg-stone-100" : ""

        <button
            className={`rounded-full border shadow px-3 py-1 aspect-square ${extraClass} hover:bg-stone-200`}
            onClick={_ => context.setPage(_ => page)}
        >
            {page->React.int}
        </button>    
    }
}

@react.component
let make = () => {
    let context = React.useContext(SearchContext.context)

    switch context.previews {
        | Some(previews) => {
            let pages = Belt.Array.range(1, previews.totalCount / 10)
            <Row className="mt-3 gap-3 justify-end overflow-x-auto">
                {Js.Array.map(page => <PaginationButton page key={page->Int.toString}/>, pages)->React.array}
            </Row>
        }
        | None => <></>
    }
}