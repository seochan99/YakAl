import ReactDOM from "react-dom/client";
import App from "./app";

declare global {
  interface Window {
    IMP: any;
  }
}

document.cookie = "SameSite=None; Secure";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(<App />);
