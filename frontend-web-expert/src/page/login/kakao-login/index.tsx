import { setCredentials } from "@/store/auth";
import { useEffect } from "react";
import { Cookies } from "react-cookie";
import { useDispatch } from "react-redux";

function KakaoLogin() {
  const dispatch = useDispatch();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken) {
      window.location.href = "/login";
    }

    dispatch(setCredentials({ user: null, token: accessToken }));

    window.location.href = "/";
  }, [dispatch]);

  return <>kakao login...</>;
}

export default KakaoLogin;
