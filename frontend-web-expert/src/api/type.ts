export type TResponse<T = null> = {
  success: boolean;
  data: T;
  error: object | null;
};

export type TLoginRedirectUrl = {
  url: string;
};

export type TTokens = {
  accessToken: string;
};
