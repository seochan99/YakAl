export interface CommonResponse<T = any> {
  success: boolean;
  data: T;
  error: object;
}
