open ProfileContext

@react.component
let make = () => {
    let context = React.useContext(ProfileContext.context)

    let onChange = (e) => {
        ReactEvent.Form.preventDefault(e)
        let value = ReactEvent.Form.target(e)["value"]

        context.setSearchQuery((_) => value)
    }

    <>
        <input
            onChange
            value={context.searchQuery}
            placeholder="Username"
            className="rounded-md h-8 w-full mx-96 px-2 py-1 border shadow-sm focus:shadow-md transition-all focus:outline-none"
        />
    </>
}