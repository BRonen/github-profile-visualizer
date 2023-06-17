@react.component
let make = (~src, ~className="", ~alt="") => {
  let className = `h-7 ${className}`

  <img src className alt />
}
