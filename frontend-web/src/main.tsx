import ReactDOM from "react-dom/client";
import App from "./app";
import React from "react";

declare global {
  interface Window {
    daum?: any; // 주소지 모듈
  }
}

document.cookie = "SameSite=None; Secure";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
