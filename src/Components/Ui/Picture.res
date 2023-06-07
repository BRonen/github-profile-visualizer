@react.component
let make = (~src, ~className="") => {
    let className = `rounded-lg border shadow-lg h-60 ${className}`

    <img src className alt="Profile picture"/>
}