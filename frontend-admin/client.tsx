import React from "react";
import * as ReactDOMClient from "react-dom/client";

const rootElement = document.getElementById("app") as HTMLElement;
const root = ReactDOMClient.createRoot(rootElement);

root.render(<React.StrictMode>Hello</React.StrictMode>);
