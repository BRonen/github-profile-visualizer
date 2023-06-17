@react.component
let make = (~className="", ~children) => {
  let className = `ml-1 pb-3 text-[#4c4f69] ${className}`

  <p className> children </p>
}
