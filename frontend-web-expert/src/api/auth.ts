import { client } from "./aixos";
import { TLoginRedirectUrl, TResponse, TTokens } from "./type";

const AUTH_HANDLER_PREFIX = "/auth";

export async function getKakaoRedirectUrl<T = TLoginRedirectUrl>(): Promise<T> {
  const response = await client.get<TResponse<T>>(`${AUTH_HANDLER_PREFIX}/kakao`);
  return response.data.data;
}

export async function loginUsingKakao<T = TTokens>(code: string): Promise<T> {
  const response = await client.get<TResponse<T>>(`${AUTH_HANDLER_PREFIX}/kakao`, {
    headers: { Authorization: code },
  });
  return response.data.data;
}

export async function reissue<T = TTokens>(): Promise<T> {
  const response = await client.post<TResponse<T>>(`${AUTH_HANDLER_PREFIX}/reissue/web`);
  return response.data.data;
}

export async function logout(): Promise<null> {
  const response = await client.patch<TResponse<null>>(`${AUTH_HANDLER_PREFIX}/logout`);
  return response.data.data;
}
