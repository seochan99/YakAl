import React from "react";
import ReactDOM from "react-dom/client";
import App from "@/app";

document.cookie = "SameSite=None; Secure";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
