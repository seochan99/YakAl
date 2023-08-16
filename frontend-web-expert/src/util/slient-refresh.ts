import { client } from "@/api/aixos";
import { reissue } from "@/api/auth";

export const TOKEN_EXPIRE_MS = 60 * 60 * 1000;

export const onSlientRefresh = () => {
  reissue().then((response) => {
    client.defaults.headers.common["Authorization"] = `Bearer ${response.accessToken}`;
    setTimeout(onSlientRefresh, TOKEN_EXPIRE_MS - 60 * 1000);
  });
};
