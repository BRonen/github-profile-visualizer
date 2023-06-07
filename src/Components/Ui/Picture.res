@react.component
let make = (~src, ~className="") => {
    let className = `rounded-lg border shadow-lg ${className}`

    <img src className alt="Profile picture"/>
}