import { client } from "@/api/aixos";
import { reissue } from "@/api/auth";
import { LOGIN_ROUTE, MAIN_DASHBOARD_ROUTE } from "@/router/router";
import { redirect } from "react-router-dom";

export const TOKEN_EXPIRE_MS = 60 * 60 * 1000;

export let slientRefreshId: NodeJS.Timeout;

export const onSlientRefresh = () => {
  reissue()
    .then((response) => {
      client.defaults.headers.common["Authorization"] = `Bearer ${response.accessToken}`;
      setTimeout(onSlientRefresh, TOKEN_EXPIRE_MS - 60 * 1000);
      localStorage.setItem("logged", "true");

      if (window.location.pathname.includes(LOGIN_ROUTE)) {
        redirect(MAIN_DASHBOARD_ROUTE);
      }
    })
    .catch((error) => {
      console.log(error);
      localStorage.setItem("logged", "false");
      redirect(LOGIN_ROUTE);
    });
};
