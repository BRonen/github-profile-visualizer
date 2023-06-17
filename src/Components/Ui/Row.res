@react.component
let make = (~className="", ~children) => {
  let className = `flex flex-row ${className}`

  <div className> children </div>
}
