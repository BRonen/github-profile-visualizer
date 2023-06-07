@react.component
let make = (~className="", ~children) => {
    let className = `text-4xl text-[#4c4f69] ${className}`
    
    <h1 className>children</h1>
}