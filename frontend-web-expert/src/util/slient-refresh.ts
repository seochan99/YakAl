import { client } from "@/api/aixos";
import { reissue } from "@/api/auth";
import { redirect } from "react-router-dom";

export const TOKEN_EXPIRE_MS = 60 * 60 * 1000;

export let slientRefreshId: NodeJS.Timeout;

export const onSlientRefresh = () => {
  reissue()
    .then((response) => {
      client.defaults.headers.common["Authorization"] = `Bearer ${response.accessToken}`;
      setTimeout(onSlientRefresh, TOKEN_EXPIRE_MS - 60 * 1000);
    })
    .catch((error) => {
      console.log(error);
      localStorage.setItem("logged", "false");
      redirect("/login");
    });
};
