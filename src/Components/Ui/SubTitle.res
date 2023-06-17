@react.component
let make = (~className="", ~children) => {
  let className = `text-2xl text-[#4c4f69] ${className}`

  <h2 className> children </h2>
}
